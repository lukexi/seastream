#!/bin/bash
sudo systemctl link `pwd`/services/seastream-oled.service
sudo systemctl link `pwd`/services/seastream-upload-recordings.service
sudo systemctl enable --now `pwd`/services/seastream-in.service
sudo systemctl enable --now `pwd`/services/seastream-out.service
sudo systemctl enable --now `pwd`/services/seastream-oled.timer
sudo systemctl enable --now `pwd`/services/seastream-upload-recordings.timer