#!/bin/bash

echo "Getting the deployment repo"
git clone https://github.com/NVIDIA-AI-IOT/tao-toolkit-triton-apps.git

echo "Building the container"
docker build -f "tao-toolkit-triton-apps/docker/Dockerfile" \
             -t nvcr.io/nvidia/tao/triton-apps:22.06-py3 tao-toolkit-triton-apps