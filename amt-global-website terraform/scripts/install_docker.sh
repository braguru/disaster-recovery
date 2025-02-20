#!/bin/bash

# # Install Docker
sudo apt update -y
sudo apt install -y docker.io

# # Start Docker
sudo systemctl start docker
sudo systemctl enable docker

sudo apt update -y
sudo apt install -y curl
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose