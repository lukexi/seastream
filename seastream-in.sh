source /home/pi/seastream.config

SDL_AUDIODRIVER="alsa" AUDIODEV="plughw:1,0" ffplay -nodisp "rtp://$DIRECT_SOURCE:1234"