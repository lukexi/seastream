#!/bin/bash
# Sets up a stream to the icecast server as configured in config-icecast.private
# and direct streams to individual seastreamers
# as listed in config-destinations.private

ENCODING_QUALITY=320k

source /home/pi/seastream/config-icecast.private
ICECAST_URL="icecast://source:$ICECAST_PASSWORD@seastream.live:1234/$ICECAST_PATH"

STREAMS="[f=mp3]$ICECAST_URL"

for DEST in $(cat config-destinations.private); do
    DEST_IP=`host $DEST | awk '/has address/ { print $4 }'`
    if [ ! -z "$DEST_IP" ]; then
        STREAMS+="|[f=rtp]rtp://$DEST_IP:1234"
    fi
done

# Streams directly to one remote destination and also to seastream.live Icecast
ffmpeg -f alsa -i plughw:1 -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg -ice_name "$ICECAST_NAME" -f tee -map 0 \
    $STREAMS
