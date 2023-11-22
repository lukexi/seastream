#!/bin/bash
# Listen to our own hostname, as streamers stream directly to us
# Use IP as hostname doesn't always resolve (maybe due to tailscale DNS?)
OUR_HOSTNAME=`uname -n`
OUR_IP=`host $OUR_HOSTNAME | awk '/has address/ { print $4 }'`
SDL_AUDIODRIVER="alsa" AUDIODEV="plughw:1,0" ffplay -nodisp "rtp://$OUR_IP:1234"