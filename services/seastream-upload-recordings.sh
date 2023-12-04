# run at 5 minutes after the hour
for sample in `ls recordings/*.part.mp3`; do
    # -Fa means show access type, 'aw' means accessed for writing
    is_being_written=`lsof -Fa -- $sample | tail -n 1`
    if [[ $is_being_written == "aw" ]]; then
        echo "Skipping active recording: $sample ..."
    else
        bash services/seastream-upload-analyze.sh $sample
    fi
done