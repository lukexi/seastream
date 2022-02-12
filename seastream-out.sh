#!/bin/bash
# Sets up a stream to the icecast server as configured in config-icecast.private
# and direct streams to individual seastreamers
# as listed in config-destinations.private

ENCODING_QUALITY=320k

source /home/pi/seastream/config-icecast.private
ICECAST_SERVER=seastream.live:1234
ICECAST_URL="icecast://source:$ICECAST_PASSWORD@$ICECAST_SERVER/$ICECAST_PATH"

STREAMS="[f=mp3]$ICECAST_URL"

for DEST in $(cat config-destinations.private); do
    DEST_IP=`host $DEST | awk '/has address/ { print $4 }'`
    if [ ! -z "$DEST_IP" ]; then
        STREAMS+="|[f=rtp]rtp://$DEST_IP:1234"
    fi
done

SOUNDCARD=hw:audioinjectorpi

# Streams directly to one remote destination and also to seastream.live icecast
# Uses workaround for high CPU usage bug in ffmpeg+alsa (-f alsa -i plughw:0) by getting audio via arecord instead
arecord -q -N -M -t raw -D $SOUNDCARD -c 2 -r 48000 -f S16_LE | \
    ffmpeg -f s16le -ac 2 -ar 48000 -i - \
    -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg -ice_name "$ICECAST_NAME" \
    -f tee -map 0 $STREAMS
