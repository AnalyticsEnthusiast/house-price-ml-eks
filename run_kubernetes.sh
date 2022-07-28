#!/usr/bin/env bash

# Step 1:
# This is your Docker ID/path
USERNAME="theanalyst6"
IMAGE_NAME="house-prediction-ml"
TAG="v1.0"
# Step 1:
# Create dockerpath
dockerpath=${USERNAME}/${IMAGE_NAME}:${TAG}

# Step 2
# Run the Docker Hub container with kubernetes
minikube kubectl -- create deploy house-pred-1 --image=${dockerpath}

# Step 3:
# List kubernetes pods
minikube kubectl -- get deploy,rs,svc,pods

# Step 4:
# Forward the container port to a host
POD_NAME=$(minikube kubectl -- get pods | awk '{ print $1 }' | tail -n1)

minikube kubectl -- port-forward pod/${POD_NAME} --address 0.0.0.0 8001:80
