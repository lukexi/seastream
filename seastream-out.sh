ENCODING_QUALITY=320k

source /home/pi/seastream.config

ICECAST_URL="icecast://source:$ICECAST_PASSWORD@seastream.live:1234/$LIVE_PATH"

STREAMS="[f=mp3]$ICECAST_URL"
# STREAMS+="|[f=rtp]rtp://$DIRECT_DESTINATION:1234"

# Streams directly to one remote destination and also to seastream.live Icecast
ffmpeg -f alsa -i plughw:1 -b:a $ENCODING_QUALITY -c:a libmp3lame \
    -content_type audio/mpeg -ice_name $STREAM_NAME -f tee -map 0 \
    $STREAMS
