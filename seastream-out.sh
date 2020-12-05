# Sets up a stream to the icecast server as configured in config-icecast.private
# and direct streams to individual seastreamers
# as listed in config-destinations.private

ENCODING_QUALITY=320k

source /home/pi/seastream/config-icecast.private
ICECAST_URL="icecast://source:$ICECAST_PASSWORD@seastream.live:1234/$ICECAST_PATH"

STREAMS="[f=mp3]$ICECAST_URL"

for DEST in $(cat config-destinations.private); do
    STREAMS+="|[f=rtp]rtp://$DESTINATION:1234"
done

# Streams directly to one remote destination and also to seastream.live Icecast
ffmpeg -f alsa -i plughw:1 -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg -ice_name "$ICECAST_NAME" -f tee -map 0 \
    $STREAMS
