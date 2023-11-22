#!/bin/bash

installer/1-tailscale.sh
installer/2-user.sh
installer/3-hardware.sh
installer/4-media.sh
installer/5-samba.sh
cd ssd1306 && make
tools/seastream-start.sh