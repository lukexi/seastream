#!/bin/bash
# Set up audioinjector driver https://github.com/Audio-Injector/stereo-and-zero
echo 'dtoverlay=audioinjector-wm8731-audio' | sudo tee -a /boot/config.txt

# Set up for Adafruit OLED Hat
echo 'dtparam=i2c_arm=on' | sudo tee -a /boot/config.txt
echo 'dtparam=i2c_baudrate=1000000' | sudo tee -a /boot/config.txt

sudo apt-get install -y i2c-tools