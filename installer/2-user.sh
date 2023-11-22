#!/bin/bash
sudo adduser pi audio # Allow audio access
sudo adduser pi i2c # Allow i2c access

# Configure git
git config --global user.email "lukexi@me.com"
git config --global user.name "Luke Iannini"
git config --global alias.st status