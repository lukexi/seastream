#!/bin/bash

# Set the Pi's hostname
read MACHINE_NAME ; export MACHINE_NAME
echo $MACHINE_NAME > /etc/hostname
echo 127.0.0.1  $MACHINE_NAME.localdomain    $MACHINE_NAME >> /etc/hosts

# Set up Tailscale
sudo apt-get install apt-transport-https
curl https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install tailscale
echo "Copy and send this link to Luke!"
sudo tailscale up

# Install ffmpeg
sudo apt-get install ffmpeg

# Set up system services
cp seastream-in.service /etc/systemd/system/
cp seastream-out.service /etc/systemd/system/

sudo systemctl enable seastream-in.service
sudo systemctl enable seastream-out.service

sudo systemctl start seastream-in.service
sudo systemctl start seastream-out.service
