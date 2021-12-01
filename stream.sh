#!/bin/bash

sudo apt-get install git cmake libjpeg-dev -y
git clone https://github.com/jacksonliam/mjpg-streamer.git
cd mjpg-streamer/
cd mjpg-streamer-experimental/
make CMAKE_BUILD_TYPE=Debug
sudo make install
export LD_LIBRARY_PATH=.
./mjpg_streamer -o "output_http.so -w ./www" -i "input_uvc.so"
