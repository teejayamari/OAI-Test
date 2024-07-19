#!/bin/bash

# Install prerequisites
sudo apt update
sudo apt install -y libsctp-dev python3.8 cmake-curses-gui libpcre2-dev python3-dev

# Install CMake (at least v3.22)
sudo apt install -y software-properties-common
sudo apt-add-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install -y cmake

# Install SWIG (at least v4.1)
git clone https://github.com/swig/swig.git
cd swig
git checkout release-4.1
./autogen.sh
./configure --prefix=/usr/
make -j8
sudo make install
cd ..

# Clone FlexRIC repository
git clone https://gitlab.eurecom.fr/mosaic5g/flexric.git
cd flexric
git checkout <release_tag>  # Replace <release_tag> with the desired release tag

# Build FlexRIC
mkdir build && cd build
cmake ..
make -j8

# Install Service Models
sudo make install

# Run tests to verify installation
ctest

# Open terminal to run components
gnome-terminal &

# Start nearRT-RIC
./build/examples/ric/nearRT-RIC

# Open 2nd terminal and Start E2 Node Agent
gnome-terminal &
./build/examples/emulator/agent/emu_agent_gnb

# Open 3rd terminal and run xApp
gnome-terminal &
./build/examples/xApp/c/monitor/xapp_kpm_moni

# Make Script Executable
chmod +x install_flexric.sh
