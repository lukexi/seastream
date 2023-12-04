source=$1
destination=proyekto.net:proyekto-server/files/seastream-archive
echo "Uploading $source (if needed) to $destination..."
rsync --progress --times $source $destination
status=`rsync --times --dry-run --itemize-changes $source $destination`
success=$?
echo Status: $status
if [[ $status == ">f"* ]]; then
    echo "File still needs upload"
elif [[ $success == 0 ]]; then
    echo "File is uploaded OK!"
    mv $source uploaded/
fi