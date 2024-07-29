#!/bin/bash

# Update and upgrade system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Necessary Dependencies

sudo apt install git

# Clone OAI Environment Repo with all components

git clone --branch master --single-branch https://github.com/teejayamari/OAI-Test.git

# Move the contents to the parent directory

cd OAI-Test
mv * ..
cd ..

# Remove the Empty OAI-Test Folder

rm -rf OAI-Test

# Setup Openairinterface5G

cd openairinterface5g/cmake_targets
./build_oai --ninja -I                       # install dependencies
./build_oai --ninja --gNB --nrUE -w SIMU -c  # compile gNB and nrUE 

# Begin setting up components using other bash scripts



