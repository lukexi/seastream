#!/bin/bash
echo "Copy (via scp) to which pi hostname/IP?"
read PI_IP
scp -pr ../seastream pi@$PI_IP:~