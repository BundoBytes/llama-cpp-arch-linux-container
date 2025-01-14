#!/bin/bash
cd /home/dev/llama.cpp/build/bin/
./llama-server -m ./models/Llama-3.1-Nemotron-70B-Instruct-HF-IQ4_XS.gguf --port 8188 --host 0.0.0.0 -ngl 73 --flash-attn -ctk q8_0 -ctv q8_0
