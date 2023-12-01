# FIXME: using 0500 to distinguish from .part files
for sample in `ls recordings/*0500.mp3`; do
    bash services/seastream-upload2.sh $sample
done