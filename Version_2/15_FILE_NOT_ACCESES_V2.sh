#####################################################################
# Script Name : 15_FILE_NOT_ACCESSED.sh
# Version :2.0
# Date : 22 Oct 2025
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
fi

echo "Finding files in '$SEARCH_DIR' not accessed in over $DAYS days:"

OUTPUT=$(find "$SEARCH_DIR" -type f -atime +"$DAYS" -print)

if [[ $? != "0" ]]; then
    echo "Error: 'find' command failed. Check permissions."
    exit 1
fi

if [ -z "$OUTPUT" ]; then
    echo "No files found matching the criteria."
else
    echo "$OUTPUT"
fi

echo "Search complete."
exit 0
