source=$1
# archive_destination=seastream-seastone:seastream-archive
archive_destination=ladybug:seastream-archive
proyekto_destination=proyekto.net:proyekto-server/files/seastream-archive

# Upload to proyekto if created between 4-6am
if [[ $source == *_AM_04*.mp3 || $source == *_AM_05*.mp3 ]]; then
    echo "Uploading $source from 4-6am to $proyekto_destination"
    rsync --remove-source-files --progress --times $source $proyekto_destination
fi

# Upload all files to archive drive
echo "Uploading $source (if needed) to $destination..."
rsync --remove-source-files --progress --times $source $archive_destination