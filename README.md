# RaspberryPiSetup
Repo for files needed to set up a Raspberry Pi with the required software for the project

## Running detection directly on the Pi
Simply download ```pi.sh``` and run it on your Pi with ```./pi.sh```. This will set up the environment and install all needed dependencies. This has been tested on a Raspberry Pi 3 Model B v1.2 with a fresh install of Raspbian 10 Buster

### Steps explained
Here is an explanation on what pi.sh does:
1. Run the ```raspi-config``` command and set up wifi and ssh if needed
2. Install python3.7 along with the matching version of pip
3. Install other required packages from the list with apt
4. Clone this repo in working directory and cd into it
5. Install both the torch and torchvision .whl files from this
6. Clone the latest Yolo-V5 repo containing the correct weight file in working directory
7. Comment out the torch and torchvision lines in requirements.txt and install it with pip
8. Cd into it, and run ```python3 detect.py --source 0 --weights YOLOv5-Lite-best.pt --iou-thres 0.3 --conf-thres 0.6 --device-id <Device-name> --buffer-time 1 --no-mask-frames 10 --show-render-time``` changing parameters such as buffer-time and no-mask-frames as needed

### Notes
- Raspberry Pi 3 Model B v1.2 uses armv7l archetecture, and official builds for the required version of torch and torchvision for armv7l do not exist. The whl files were compiled from source in a Docker container emulating an armv7l architecture using qemu. Trying to build from source directly on a Pi would take several days. See https://ownyourbits.com/2018/06/27/running-and-building-arm-docker-containers-in-x86/ for more information on this process.
- If you get an error of type ```filename.whl is not a supported wheel on this platform``` when installing torch or torchvision, check to make sure you have the correct python version instlalled (3.7 in this case). The default version of python3 differs in different OS releases.

## Streaming video from the Pi to a remote server
Running the detection software on the Pi is possible, but with older models might be too slow for good performance. A solution for this is to stream the video feed from the Pi to a local http server and access that from a more powerful server that is running the mask detection software. We can run ```stream.sh``` to set this stream up, and then start the detection software on a different server

### Steps Explained
Here is an explanation of what stream.sh does:
1. Run the ```raspi-config``` command and set up wifi and ssh if needed
2. Install git and other build dependencies
3. Use git to download mjpg-streamer
4. Compile and build mjpg-streamer
5. Set environment variable needed to run
6. Run ```./mjpg_streamer -o "output_http.so -w ./www" -i "input_uvc.so"``` to start the stream
Once the stream is running, clone the latest Yolo-V5 repo and run ```python3 detect.py --source 'http://<Pi IP Adress>:8080/?action=stream' --weights YOLOv5-Lite-best.pt --iou-thres 0.3 --conf-thres 0.6 --device-id Pi-Stream --buffer-time 1 --no-mask-frames 10 --show-render-time```. You can get the Pi's IP adress by running ```if-config``` on it.

### Notes
- This was tested on a Raspberry Pi 3 Model B v1.2 with a fresh install of Raspbian 10 Buster. If using a different distro, dependency package names may differ.
- The procedure for setting up the mjpg streamer was taken from https://desertbot.io/blog/how-to-stream-the-picamera. You may change the default settings in mjpg-streamer to suit your needs
