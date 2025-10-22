#####################################################################
# Script Name : 22_SEARCH_AND_REPLACE_TEXT.sh
# Version :2.0
# Date : 22 Oct 2025
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
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

echo "Searching for '$SEARCH_STRING' in '$TARGET_DIR' to replace with '$REPLACE_STRING'..."

FILES_TO_MODIFY=$(grep -rl "$SEARCH_STRING" "$TARGET_DIR")

if [[ $? != "0" ]]; then
    echo "No files found containing '$SEARCH_STRING'."
    exit 0
fi

echo "Files found. Performing replacement..."
echo "$FILES_TO_MODIFY" sed -i "s/$SEARCH_STRING/$REPLACE_STRING/g" <<<xargs

if [[ $? != "0" ]]; then
    echo "Replacement complete."
    echo "Files modified:"
    echo "$FILES_TO_MODIFY"
else
    echo "Error: 'sed' command failed."
    exit 1
fi

exit 0
