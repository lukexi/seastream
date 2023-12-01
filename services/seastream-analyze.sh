sample=$1
echo "Analyzing $sample..."
# Returns multiplier needed to normalize audio file;
# 2 = highest peak is at 50% max volume, 50 = highest peak is at 2% max volume
inverse_amp_float=`sox $sample -n stat -v 2>&1`
inverse_amp=${inverse_amp_float%.*}
amplitude_percent=$((100/inverse_amp))
echo Amplitude level: $amplitude_percent / 100

if [[ $amplitude_percent -gt 2 ]]; then
    echo "> $sample has audio"
    mv "$sample" "${sample%.part.mp3}.mp3"
else
    echo "> $sample is silent!"
    mv "$sample" silent/
fi