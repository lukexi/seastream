# NOTE: too slow to run at same time as stream for Pi Zero 1
# outputs multiplier to normalize file to 0db - so anything over e.g. 20 is a silent file.
# normal values are something like 6x
sox seastone_2023-11-21_01-27-00_AM_-0500.mp3 -n stat -v