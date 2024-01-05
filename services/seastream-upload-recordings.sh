# run at 5 minutes after the hour
for sample in `find recordings -name *.part`; do
    # -Fa means show access type, 'aw' means accessed for writing
    is_being_written=`lsof -Fa -- $sample | tail -n 1`
    if [[ $is_being_written == "aw" ]]; then
        echo "Skipping active recording: $sample ..."
    else
        bash services/seastream-analyze.sh $sample
    fi
done

for sample in `find recordings -name *.mp3`; do
    bash services/seastream-upload.sh $sample
done


