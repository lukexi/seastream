#!/bin/bash
# Sets up a stream to the icecast server as configured in config-icecast.private
# and direct streams to individual seastreamers
# as listed in config-destinations.private

ENCODING_QUALITY=320k

source /home/pi/seastream/config.private

ICECAST_SERVER=seastream.live:1234
ICECAST_URL="icecast://source:$ICECAST_PASSWORD@$ICECAST_SERVER/$ICECAST_PATH"

STREAMS="[f=mp3]$ICECAST_URL"

for DEST in $DESTINATIONS; do
    DEST_IP=`host $DEST | awk '/has address/ { print $4 }'`
    if [ ! -z "$DEST_IP" ]; then
        STREAMS+="|[f=rtp:ice_name=$ICECAST_NAME]rtp://$DEST_IP:1234"
    fi
done

# Record 1-hour chunks, labelled with artist and time
STREAMS+="|[f=segment:segment_time=3600:strftime=1:segment_atclocktime=1]$ICECAST_PATH_%Y-%m-%d_%I-%M-%S_%p_%z.mp3"
# TODO: upload these to proyekto, only if sox says they have audio content, otherwise delete.

# Streams to all $STREAMS
# Uses workaround for high CPU usage bug in ffmpeg+alsa (-f alsa -i plughw:0) by getting audio via arecord instead
arecord -q -N -M -t raw -D plughw:$SOUNDCARD -c 2 -r 48000 -f S32_LE | \
    ffmpeg -f s32le -ac 2 -ar 48000 -i - \
    -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg \
    -f tee -map 0 $STREAMS
