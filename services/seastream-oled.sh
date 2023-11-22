#!/bin/bash

SEASTREAM_STATE=`systemctl show seastream-out -P ActiveState`
WIFI_NAME=`iwgetid -r`
DISK_FREE=`df -h / --output=avail | tail -n1`
NUM_RECS=`find /home/pi/seastream -maxdepth 1 -type f -name "*.mp3" | wc -l`

/home/pi/seastream/ssd1306/ssd1306_bin -n1 -r 180 -c -m "\nseastream: $SEASTREAM_STATE\nwifi: $WIFI_NAME\nrecs: $NUM_RECS hrs\nfree: $DISK_FREE"