#!/usr/bin/env bash

# Build image and add a descriptive tag
echo "Build docker image"
docker build --tag=udacity-capstone-project .

# List docker images
echo "Listing docker images"
docker image ls

# Run flask app
echo "Run flask app"
docker run -p 8000:80 udacity-capstone-project