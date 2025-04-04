#!/bin/bash

set -e


#Run Hello world container
docker run hello-world

# List running containers
docker ps

mkdir my-docker-webpage
cd my-docker-webpage

# Variables
PROJECT_NAME="my-docker-webpage"
IMAGE_NAME="my-nginx-page"
CONTAINER_NAME="my-nginx-container"
PORT=8080
USERNAME="Anton"

# Step 1: Create Project Directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Step 2: Create index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
</head>
<body>
    <h1>$USERNAME 2024</h1>
</body>
</html>
EOF

# Step 3: Create Nginx Configuration File
cat <<EOF > default.conf
server {
    listen 0.0.0.0:80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Step 4: Create Dockerfile
cat <<EOF > Dockerfile
# Use the official Nginx base image
FROM nginx:alpine

# Copy the Nginx configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the HTML file into the container
COPY index.html /usr/share/nginx/html/index.html
EOF

# Step 5: Build Docker Image
docker build -t "$IMAGE_NAME" .

# Step 6: Run Docker Container
docker run -d -p "$PORT":80 --name "$CONTAINER_NAME" "$IMAGE_NAME"

# Output the access URL
echo "Your webpage is now accessible at http://localhost:$PORT"