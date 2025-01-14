#!/bin/bash
cd /home/dev/llama.cpp/build/bin/
./llama-server -m ./models/Monstral-123B-v2-IQ2_XXS.gguf --port 8188 --host 0.0.0.0 -ngl 88 --flash-attn -ctk q8_0 -ctv q8_0 --ctx-size 12288 --dry-multiplier 0.8
