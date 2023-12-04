# Assembles a cross-fading collection of files
# using ffmpeg's filter_complex.
# Each fade section is named, and then the next section
# can refer to previous named-fade sections to add another
# fade.

# Can loop by just repeating the filename a bunch of times,
# not sure there's a better way, can just have it 
# restart at 4am or something

FILES=`ls seastone-2023-11-22*`
CMD+="ffmpeg"
for file in $FILES; do
    CMD+=" -i $file"
end

# CMD+=" -stream_loop -1" # TODO check syntax and that this works

CMD+=" -filter_complex"
CROSS_DURATION=5
FROM=0
I=0
for file in $FILES; do
    I_N=$((I+1))
    NAME="[fade$I$I_N]"
    CMD+="[$FROM][$I_N]acrossfade=d=$CROSS_DURATION[$NAME];"
    FROM=$NAME
end
echo $CMD