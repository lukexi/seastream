#!/bin/bash
# Sets up a stream to the icecast server as configured in config-icecast.private
# and direct streams to individual seastreamers
# as listed in config-destinations.private

ENCODING_QUALITY=320k

source /home/pi/seastream/config.private

ICECAST_SERVER=seastream.live:1234
ICECAST_URL="icecast://source:$ICECAST_PASSWORD@$ICECAST_SERVER/$ARTIST_PATH"

STREAMS="[f=mp3:ice_name=$ARTIST_NAME]$ICECAST_URL"

for DEST in $DESTINATIONS; do
    DEST_IP=`host $DEST | awk '/has address/ { print $4 }'`
    if [ ! -z "$DEST_IP" ]; then
        STREAMS+="|[f=rtp]rtp://$DEST_IP:1234"
    fi
done

RECORD_DIR=recordings # FUTURE: make this configurable for external HDD etc.
mkdir -p "$RECORD_DIR"

AVAIL_HD_SPACE=`df $RECORD_DIR --output=avail | tail -n1`
# Check for at least 1GB free
if [[ $AVAIL_HD_SPACE -gt 1000000 ]]; then
    # Record 1-hour chunks every hour on the hour
    STREAMS+="|[f=segment:segment_time=3600:strftime=1:segment_atclocktime=1]"
    # chunk filename - year month day am/pm hour minute second timezone
    STREAMS+="$RECORD_DIR/$ARTIST_PATH-%Y-%m-%d_%p_%I-%M-%S_%z.part.mp3"
fi

# Streams to all $STREAMS
# (Uses workaround for high CPU usage bug in 
# ffmpeg+alsa (-f alsa -i plughw:0) by getting audio via arecord instead)
arecord -q -N -M -t raw -D plughw:$SOUNDCARD -c 2 -r 48000 -f S32_LE | \
    ffmpeg -f s32le -ac 2 -ar 48000 -i - \
    -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg \
    -f tee -map 0 $STREAMS
