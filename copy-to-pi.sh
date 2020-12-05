#!/bin/bash
echo "Copy (via scp) to which pi hostname/IP?"
read PI_IP
scp -p * pi@$PI_IP:~