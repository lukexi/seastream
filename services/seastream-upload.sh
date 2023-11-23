for SAMPLE in `ls *.part.mp3`; do
    echo "Analyzing $SAMPLE..."
    # Returns multiplier needed to normalize audio file;
    # 2 = highest peak is at 50% max volume, 50 = highest peak is at 2% max volume
    NORMALIZATION_LEVEL=`sox $SAMPLE -n stat -v`
    if (($NORMALIZATION_LEVEL < 50)); then
        echo "$SAMPLE has audio!"
        mv "$SAMPLE" "${SAMPLE%.part.mp3}.mp3"
    else
        echo "$SAMPLE is silent!"
        mv "$SAMPLE" "${SAMPLE%.part.mp3}.silent.mp3"
    fi
done