#!/bin/bash

# Set up Tailscale
if [[ $(dpkg-query -W -f='${Status}' tailscale 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
    sudo apt-get install apt-transport-https --assume-yes
    curl https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
    curl https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    sudo apt-get update --assume-yes
    sudo apt-get install tailscale --assume-yes
    sudo tailscale up
fi

# Set the Pi's hostname
if [[ $(hostname -s) -eq raspberrypi ]]; then
    echo "What's your name? (all lowercase, e.g. seastone, evolvingpink - this will be the pi's hostname)"
    read MACHINE_NAME ; export MACHINE_NAME
    sudo sh -c "echo $MACHINE_NAME > /etc/hostname"
    sudo sh -c "echo 127.0.0.1  $MACHINE_NAME.localdomain    $MACHINE_NAME >> /etc/hosts"
fi

# Install ffmpeg
sudo apt-get update --assume-yes
sudo apt-get install ffmpeg --assume-yes

echo "Enter destinations in config-destinations.private"
cp config-destinations.private.template config-destinations.private
echo "Configure icecast in config-icecast.private"
cp config-icecast.private.template config-icecast.private

# Set up system services
./seastream-start.sh