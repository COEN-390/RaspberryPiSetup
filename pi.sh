#!/bin/bash

###To configure Wifi and SSH if needed
#sudo raspi-config

cd ~
sudo apt update
sudo apt install git python3-pip -y
git clone https://github.com/COEN-390/RaspberryPiSetup && cd RaspberryPiSetup
pyhton3 -m pip install torch-1.7.0a0-cp37-cp37m-linux_armv7l.whl
python3 -m pip install torchvision-0.8.0a0+45f960c-cp37-cp37m-linux_armv7l.whl
cd .. && git clone https://github.com/COEN-390/YOLOv5-Lite && cd YOLOv5-Lite
python3 -m pip install -r requirements.txt

###To start the software
#python3 detect.py --weights YOLOv5-Lite-best.pt --source 0