#!/bin/bash
sudo systemctl enable --now `pwd`/services/seastream-in.service
sudo systemctl enable --now `pwd`/services/seastream-out.service