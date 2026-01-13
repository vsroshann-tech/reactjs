#!/bin/bash
set -e

IMAGE_NAME=yourdockerhubusername/dev
TAG=$(date +%Y%m%d%H%M)

echo "Logging into DockerHub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "Building Docker image..."
docker build -t $IMAGE_NAME:$TAG .

echo "Tagging latest..."
docker tag $IMAGE_NAME:$TAG $IMAGE_NAME:latest

echo " Pushing image..."
docker push $IMAGE_NAME:$TAG
docker push $IMAGE_NAME:latest

echo "Logging out..."
docker logout

echo " Done"
