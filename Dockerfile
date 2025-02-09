FROM archlinux

EXPOSE 8188

ENV PACMAN_FLAGS="--noconfirm --needed --disable-sandbox" VISUAL=nvim EDITOR=nvim

RUN pacman -Syu $PACMAN_FLAGS

RUN pacman -Syu git neovim locate sudo libgl base-devel less wget openmpi plocate $PACMAN_FLAGS

RUN groupadd sudo
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1001 -p "$(openssl passwd -1 password)" dev
# Gives the user root permissions:
#RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER dev
WORKDIR /home/dev

# Install CUDA and gcc
RUN wget https://archive.archlinux.org/packages/g/gcc/gcc-13.2.1-6-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/c/cuda/cuda-12.6.3-1-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/g/gcc-libs/gcc-libs-13.2.1-6-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/c/cmake/cmake-3.29.2-1-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/j/jsoncpp/jsoncpp-1.9.5-2-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/c/cppdap/cppdap-1.58.0-1-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/c/ccache/ccache-4.9.1-1-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/g/glibc/glibc-2.40-1-x86_64.pkg.tar.zst
USER root
RUN pacman -U ${PACMAN_FLAGS} gcc-13.2.1-6-x86_64.pkg.tar.zst gcc-libs-13.2.1-6-x86_64.pkg.tar.zst cmake-3.29.2-1-x86_64.pkg.tar.zst jsoncpp-1.9.5-2-x86_64.pkg.tar.zst cppdap-1.58.0-1-x86_64.pkg.tar.zst ccache-4.9.1-1-x86_64.pkg.tar.zst glibc-2.40-1-x86_64.pkg.tar.zst
RUN pacman -U ${PACMAN_FLAGS} /home/dev/cuda-12.6.3-1-x86_64.pkg.tar.zst

ENV PATH=$PATH:/opt/cuda/bin
USER dev

# Install Llama.cpp
RUN git clone https://github.com/ggerganov/llama.cpp
RUN cd llama.cpp \
    && cmake -B build -DGGML_CUDA=ON -DGGML_CUDA_FORCE_CUBLAS=ON -DGGML_CUDA_F16=ON -DGGML_CUDA_FA_ALL_QUANTS=ON

USER root
COPY start_server.sh /home/dev/
COPY build_server.sh /home/dev/
RUN chown dev:root /home/dev/start_server.sh && chmod +x /home/dev/start_server.sh
RUN chown dev:root /home/dev/build_server.sh && chmod +x /home/dev/build_server.sh
USER dev

CMD ["bash"]
