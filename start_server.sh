#!/bin/bash
cd /home/dev/llama.cpp/build/bin/
./llama-server -m ./models/DeepSeek-R1-Distill-Llama-70B-IQ3_M.gguf --port 8000 --host 0.0.0.0 -ngl 88 --flash-attn -ctk q8_0 -ctv q8_0 --ctx-size 12288 --xtc-probability 0.5 --xtc-threshold 0.15
# For more info on the parameters, visit:
# https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md
