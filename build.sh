#!/bin/bash

# Exit on any error
set -e

# Docker Hub credentials from environment
DOCKER_USER=${DOCKER_USER:-yourdockerhubusername}
DOCKER_PASS=${DOCKER_PASS:-yourdockerhubtoken}

# Docker image info
IMAGE_NAME=$DOCKER_USER/dev-app
TAG=$(date +%Y%m%d%H%M)

echo "Logging into Docker Hub..."
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "Building Docker image..."
docker build -t $IMAGE_NAME:$TAG .

echo "Tagging as latest..."
docker tag $IMAGE_NAME:$TAG $IMAGE_NAME:latest

echo "Pushing Docker images..."
docker push $IMAGE_NAME:$TAG
docker push $IMAGE_NAME:latest

echo "Docker image build & push completed successfully!"
