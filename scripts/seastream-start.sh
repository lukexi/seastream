#!/bin/bash
sudo systemctl enable --now `pwd`/services/seastream-in.service
sudo systemctl enable --now `pwd`/services/seastream-out.service
sudo systemctl link `pwd`/services/seastream-oled.service
sudo systemctl enable --now `pwd`/services/seastream-oled.timer