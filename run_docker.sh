#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t house-prediction-ml .
# Step 2: 
# List docker images
docker image ls
# Step 3: 
# Run flask app
docker run -d --rm -p 8001:80 --name house-pred-1 house-prediction-ml