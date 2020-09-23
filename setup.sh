#!/bin/bash

# Set up Tailscale
sudo apt-get install apt-transport-https --assume-yes
curl https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update --assume-yes
sudo apt-get install tailscale --assume-yes
sudo tailscale up

# Set the Pi's hostname
echo "What's your name? (e.g. seastone, evolving pink...)"
read MACHINE_NAME ; export MACHINE_NAME
sudo sh -c "echo $MACHINE_NAME > /etc/hostname"
sudo sh -c "echo 127.0.0.1  $MACHINE_NAME.localdomain    $MACHINE_NAME >> /etc/hosts"

# Install ffmpeg
sudo apt-get install ffmpeg

# Set up system services
sudo cp seastream-in.service /etc/systemd/system/
sudo cp seastream-out.service /etc/systemd/system/

sudo systemctl enable seastream-in.service
sudo systemctl enable seastream-out.service

sudo systemctl start seastream-in.service
sudo systemctl start seastream-out.service