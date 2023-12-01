#!/bin/bash

stream_state=`systemctl show seastream-out -P ActiveState`
wifi_name=`iwgetid -r`
disk_free=`df -h / --output=avail | tail -n1`
num_recordings=`find /home/pi/seastream -maxdepth 1 -type f -name "*.mp3" | wc -l`

screen="\n"
screen+="seastream: $stream_state\n"
screen+="wifi: $wifi_name\n"
screen+="recs: $num_recordings hrs\n"
screen+="free: $disk_free\n"

/home/pi/seastream/ssd1306/ssd1306_bin -n1 -r 180 -c -m "$screen"