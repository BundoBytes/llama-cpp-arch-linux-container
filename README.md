## llama.cpp Arch Linux Container
This is a podman script to build an environment capable of running llama.cpp in Arch Linux.

---
### Getting Started
0. Ensure your Podman/Docker is properly setup with nvidia-container-toolkit installed.
1. Please go through the Dockerfile and modify it as you see fit. In particular:
    ```docker
    RUN cd llama.cpp \
        && cmake -B build -DGGML_CUDA=ON \
        -DGGML_CUDA_FORCE_CUBLAS=ON \
        -DGGML_CUDA_F16=ON \
        -DGGML_CUDA_FA_ALL_QUANTS=ON
    ```
    Visit [llama.cpp cuda args](https://github.com/ggerganov/llama.cpp/blob/master/docs/build.md#cuda) for more info.

2. Execute 'podman-compose build' to create the image.
3. 'podman-compose up' will create and run the container.
