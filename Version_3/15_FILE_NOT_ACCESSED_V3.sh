#####################################################################
# Script Name : 15_FILE_NOT_ACCESSED_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose :  Finds files not accessed in N days.
####################################################################

#!/bin/bash

SEARCH_DIR="$1"
DAYS="$2"

if [[ $# != "2" ]]; then
    echo "Usage: $0 [directory] [days]"
    exit 1
fi

if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory '$SEARCH_DIR' not found."
    exit 1
else

    echo "Finding files in '$SEARCH_DIR' not accessed in over $DAYS days:"

    OUTPUT=$(find "$SEARCH_DIR" -type f -atime +"$DAYS" -print)

    if [[ $? != "0" ]]; then
        echo "Error: 'find' command failed. Check permissions."
        exit 1
    elif [ -z "$OUTPUT" ]; then
        echo "No files found matching the criteria."
        exit 1
    else
        echo "$OUTPUT"
    fi

    echo "Search complete."
    exit 0
fi
