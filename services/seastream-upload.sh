# or lsof -f file.mp3 for each file?
active_recording=`lsof -c ffmpeg +D recordings/`
echo Active recording: $active_recording

# run at 5 minutes after the hour
for sample in `ls recordings/*.part.mp3`; do
    is_active=`lsof -f -- "$sample"`
    echo "> In use? $is_active"
    bash services/seastream-analyze.sh $sample
done

# for sample in `ls *.part.mp3`; do
#     services/seastream-analyze.sh $sample
# done