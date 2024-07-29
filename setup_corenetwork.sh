#!/bin/bash

# Update and upgrade system packages
sudo apt-get update
sudo apt-get upgrade -y

# Setup core network

cd oai-spring-of-code/
cd cn/

# Install necessary dependencies

snap install curl
sudo apt-get update
sudo apt-get install -y curl
sudo curl -SL https://github.com/docker/compose/releases/download/v2.26.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Docker

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Start and Enable Docker

sudo systemctl start docker
sudo systemctl enable docker
sudo docker compose pull

# Deploy core network

sudo docker compose -f docker-compose.yml up -d mysql

# Start core network

sudo docker compose -f docker-compose.yml up -d

