#!/bin/bash

# Set variables
PROJECT_NAME="exadel-devops-traning-spring-web-app"
IMAGE_NAME="exadel-devops-traning-web-app"
CONTAINER_NAME="exadel-devops-traning-web-app-container"
PORT=8079

# Navigate to the project directory
cd .. || { echo "Project directory not found"; exit 1; }

# Build the Docker image
echo "Building the Docker image..."
docker build -t "$IMAGE_NAME" . || { echo "Docker build failed"; exit 1; }

# Run the Docker container
echo "Running the Docker container..."
docker run -d -p "$PORT":8080 --name "$CONTAINER_NAME" "$IMAGE_NAME" || { echo "Failed to start Docker container"; exit 1; }

echo "Application is running at http://localhost:$PORT"
