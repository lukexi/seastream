#!/bin/bash
# Listen to our own hostname, as streamers stream directly to us
# Use IP as hostname doesn't always resolve (maybe due to tailscale DNS?)
source /home/pi/seastream/config.private

OUR_HOSTNAME=`uname -n`
OUR_IP=`host $OUR_HOSTNAME | awk '/has address/ { print $4 }'`
SDL_AUDIODRIVER="alsa" AUDIODEV="plughw:$SOUNDCARD" ffplay -nodisp "rtp://$OUR_IP:1234"