#####################################################################
# Script Name : 16_ORGANIZE_FILES.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Organize files in a directory to subfolders.
####################################################################

#!/bin/bash

TARGET_DIR="$1"
if [[ $# != "1" ]]; then
    echo "Usage: $0 [directory_path]"
    exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

IMG_DIR="$TARGET_DIR/Images"
DOC_DIR="$TARGET_DIR/Documents"
AUD_DIR="$TARGET_DIR/Audio"
VID_DIR="$TARGET_DIR/Video"
ARC_DIR="$TARGET_DIR/Archives"
OTH_DIR="$TARGET_DIR/Others"

echo "Creating destination directories..."
mkdir -p "$IMG_DIR" "$DOC_DIR" "$AUD_DIR" "$VID_DIR" "$ARC_DIR" "$OTH_DIR"

echo "Organizing files in $TARGET_DIR..."

find "$TARGET_DIR" -maxdepth 1 -type f | while IFS= read -r file; do

    filename=$(basename "$file")
    extension=$(echo "${filename##*.}" | tr '[:upper:]' '[:lower:]')

    if [ "$filename" == "$extension" ]; then
        extension="other"
    fi
    echo -n "Processing $filename... "

    case "$extension" in

    png | jpg | jpeg | gif | bmp | svg)
        mv "$file" "$IMG_DIR/"
        echo "Moved to Images."
        ;;

    doc | docx | pdf | txt | odt | rtf | ppt | xls)
        mv "$file" "$DOC_DIR/"
        echo "Moved to Documents."
        ;;

    mp3 | wav | ogg | flac | aac)
        mv "$file" "$AUD_DIR/"
        echo "Moved to Audio."
        ;;

    mp4 | mkv | avi | mov | wmv)
        mv "$file" "$VID_DIR/"
        echo "Moved to Video."
        ;;

    zip | rar | 7z | tar | gz | bz2)
        mv "$file" "$ARC_DIR/"
        echo "Moved to Archives."
        ;;

    *)
        mv "$file" "$OTH_DIR/"
        echo "Moved to Others."
        ;;
    esac
done

echo "Organization complete."
exit 0
