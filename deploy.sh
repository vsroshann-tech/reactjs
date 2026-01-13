#!/bin/bash

echo "Pulling latest image..."
docker-compose pull

echo "Stopping existing containers..."
docker-compose down

echo "Starting containers..."
docker-compose up -d

echo "Deployment completed!"
