#####################################################################
# Script Name : 23_SEARCH_AND_REPLACE_TEXT_V3.sh
# Version :3.0
# Date : 23 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Search for text in files of specific pattern and replace to desired one.
####################################################################

#!/bin/bash

TARGET_DIR="$1"
SEARCH_STRING="$2"
REPLACE_STRING="$3"

if [[ $# != "3" ]]; then
    echo "Usage: $0 [directory] [search_string] [replace_string]"
    exit 1
elif [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
else

    echo "Searching for '$SEARCH_STRING' in '$TARGET_DIR' to replace with '$REPLACE_STRING'..."

    FILES_TO_MODIFY=$(grep -rl "$SEARCH_STRING" "$TARGET_DIR")

    if [[ $? != "0" ]]; then
        echo "No files found containing '$SEARCH_STRING'."
        exit 0
    else

        echo "Files found. Performing replacement..."
        while read -r file; do

            sed -i "s/$SEARCH_STRING/$REPLACE_STRING/g" "$file"

            if [[ $? != "0" ]]; then
                echo "Error: 'sed' command failed on file: $file"
            fi
        done <<<"$FILES_TO_MODIFY"

        echo "Replacement complete."
        echo "Files modified:"
        echo "$FILES_TO_MODIFY"

    fi
    exit 0
fi
