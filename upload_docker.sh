#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

USERNAME="theanalyst6"
IMAGE_NAME="house-prediction-ml"
TAG="v1.0"
# Step 1:
# Create dockerpath
dockerpath=${USERNAME}/${IMAGE_NAME}:${TAG}

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login

docker tag ${IMAGE_NAME}:latest ${dockerpath}

# Step 3:
# Push image to a docker repository
docker push ${dockerpath}