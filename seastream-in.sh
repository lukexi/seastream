#!/bin/bash
# Listen to our own hostname, as streamers stream directly to us
DIRECT_SOURCE=`uname -n`
SDL_AUDIODRIVER="alsa" AUDIODEV="plughw:1,0" ffplay -nodisp "rtp://$DIRECT_SOURCE:1234"