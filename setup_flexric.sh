# Go to home directory

cd

# Install SWIG

git clone https://github.com/swig/swig.git
cd swig
git checkout release-4.1
./autogen.sh

# Install dependencies

sudo apt-get update
sudo apt-get install -y libpcre2-dev
sudo apt install libsctp-dev python3.8 cmake-curses-gui libpcre2-dev python3-dev

# Continue configuration
make -j8
sudo make install

# Go to FlexRIC directory
cd flexric && mkdir build && cd build && cmake .. && make -j8
sudo make install
ctest
