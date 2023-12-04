source=$1
destination=proyekto.net:proyekto-server/files/seastream-archive
echo "Uploading $source (if needed) to $destination..."
rsync --progress --times $source $destination
status=`rsync --times --dry-run --itemize-changes $source $destination`
echo Status: $status
if [[ $status == ">f"* ]]; then
    echo "File still needs upload"
else
    echo "File is uploaded OK!"
    mv $source uploaded/
fi