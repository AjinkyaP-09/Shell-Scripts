#####################################################################
# Script Name : 24_RENAME_FILES_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Rename files in a specific dir to desired format.
####################################################################

#!/bin/bash

TARGET_DIR="$1"
OLD_TEXT="$2"
NEW_NAME="$3"

if [[ $# != "3" ]]; then
    echo "Usage: $0 [directory] [old_text] [new_text]"
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

if [ -z "$OLD_TEXT" ]; then
    echo "Error: 'old_text' cannot be empty."
    exit 1
fi

echo "Searching in '$TARGET_DIR' for files containing '$OLD_TEXT' to rename to '$NEW_NAME'..."

find "$TARGET_DIR" -maxdepth 1 -type f | while IFS= read -r file; do

    filename=$(basename "$file")

    if [[ "$filename" == *"$OLD_TEXT"* ]]; then
        new_filename=$(echo "$filename" | sed "s/$OLD_TEXT/$NEW_NAME/g")
        new_filepath="$TARGET_DIR/$new_filename"

        if [ "$file" != "$new_filepath" ]; then
            echo -n "Renaming '$filename' to '$new_filename'..."
            if ! mv "$file" "$new_filepath"; then
                echo "Failed!"
            else
                echo "Done."
            fi
        fi
    fi
done

echo "Renaming complete."
exit 0
