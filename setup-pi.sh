#!/bin/bash

# Set the Pi's hostname
read MACHINE_NAME ; export MACHINE_NAME
echo $MACHINE_NAME > /etc/hostname
echo 127.0.0.1  $MACHINE_NAME.localdomain    $MACHINE_NAME >> /etc/hosts

# Set up Tailscale


# Install ffmpeg
sudo apt-get install ffmpeg

# Set up system services
cp seastream-in.service /etc/systemd/system/
cp seastream-out.service /etc/systemd/system/

sudo systemctl enable seastream-in.service
sudo systemctl enable seastream-out.service

sudo systemctl start seastream-in.service
sudo systemctl start seastream-out.service
