# seastream

# Pi hardware setup
* Copy files to SD card
* Edit `wpa_supplicant.conf` with your Wifi username and password
* Boot the pi
* In Terminal:
```
ssh pi@raspberrypi.local
sudo apt-get install git
git clone https://github.com/lukexi/seastream
cd seastream
./setup.sh
```
* Send the Tailscale URL to me

# Pi software setup
```
# note name of e.g. "card 1: MGXU" or "card 1: audioinjectorpi", name would be SOUNDCARD=hw:audioinjectorpi or SOUNDCARD=hw:MGXU respectively
arecord -l 
# Create a private config file
cp -u config.private.template config.private
# set destinations, enter password, set soundcard name
nano config.private
```