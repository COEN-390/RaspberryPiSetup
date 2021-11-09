# RaspberryPiSetup
Repo for files needed to set up a Raspberry Pi with the PyTorch software

## Procedure for setting up the Pi
Here are the rough steps for setting up the environment. This has been tested on a Raspberry Pi 3 Model B v1.2 with a fresh install of Raspbian 10 Buster

1. Load Raspbian image on a sd card
2. Run the ```raspi-config``` command and set up wifi and ssh if needed
3. Install python3.7 along with the matching version of pip
4. Install other required packages from the list with apt
5. Clone this repo in working directory and cd into it
6. Install both the torch and torchvision .whl files from this
7. Comment out the torch and torchvision lines in requirements.txt and install it with pip
8. Clone the latest Yolo-V5 repo containing the correct weight file in working directory
9. Cd into it, and run ```python3 detect.py --weights <weightfile.pt> --source <image.png, or 0 for camera>``` 

### Notes
- Raspberry Pi 3 Model B v1.2 uses armv7l archetecture, and official builds for the required version of torch and torchvision for armv7l do not exist. The whl files were compiled from source in a Docker container emulating an armv7l architecture using qemu. Trying to build from source directly on a Pi would take several days. See https://ownyourbits.com/2018/06/27/running-and-building-arm-docker-containers-in-x86/ for more information on this process.
