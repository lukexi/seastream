#!/bin/bash
sudo systemctl stop seastream-in
sudo systemctl stop seastream-out
sudo systemctl stop seastream-oled.timer
sudo systemctl stop seastream-upload-recordings.timer