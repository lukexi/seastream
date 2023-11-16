#!/bin/bash

# Set up Tailscale
installer/setup-1-tailscale.sh

# Allow audio access
sudo adduser pi audio
# Allow i2c access
sudo adduser pi i2c

# Set up audioinjector driver https://github.com/Audio-Injector/stereo-and-zero
echo 'dtoverlay=audioinjector-wm8731-audio' | sudo tee -a /boot/config.txt
amixer -D hw:CARD=audioinjectorpi set 'Output Mixer HiFi' unmute

# Set up for Adafruit OLED Hat
echo 'dtparam=i2c_arm=on' | sudo tee -a /boot/config.txt
echo 'dtparam=i2c_baudrate=1000000' | sudo tee -a /boot/config.txt
sudo apt-get install -y i2c-tools

# Set the Pi's hostname
if [[ $(hostname -s) -eq raspberrypi ]]; then
    echo "What's your name? (all lowercase, e.g. seastone, evolvingpink - this will be the pi's hostname)"
    read MACHINE_NAME ; export MACHINE_NAME
    sudo sh -c "echo $MACHINE_NAME > /etc/hostname"
    sudo sh -c "echo 127.0.0.1  $MACHINE_NAME.localdomain    $MACHINE_NAME >> /etc/hosts"
fi

git config --global user.email "lukexi@me.com"
git config --global user.name "Luke Iannini"
git config --global alias.st status

# Install ffmpeg
sudo apt-get update --assume-yes
sudo apt-get install ffmpeg --assume-yes

echo "Enter destinations, password and soundcard in config.private"
cp config.private.template config.private

# Install samba
sudo apt-get install samba
sudo cp smb.conf /etc/samba/smb.conf
echo "Enter pi password"
sudo smbpasswd -a pi
sudo systemctl restart smbd

# Set up system services
./seastream-start.sh