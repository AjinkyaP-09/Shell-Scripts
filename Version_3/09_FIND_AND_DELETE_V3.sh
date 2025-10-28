#####################################################################
# Script Name : 09_FIND_AND_DELETE_FILE_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose :  Write a shell script that scans a directory for files matching a certain pattern and deletes them.
####################################################################

#!/bin/bash

DIR_PATH=$1
FILE_PATTERN=$2

if (($# != 2)); then
    echo "Usage: $0 DIR_PATH FILE_PATTERN"
    exit 1
else
    if [[ -d "$DIR_PATH" ]]; then
        echo "Finding and deleting files of pattern $FILE_PATTERN from $DIR_PATH..."
        find $DIR_PATH -name "$FILE_PATTERN" -type f -delete
        if [[ $? -eq 0 ]]; then
            echo "Deleted files of pattern $FILE_PATTERN."
        else
            echo "Failure while deleting files."
        fi
    else
        echo "$DIR_PATH does not exist or is not a directory."
    fi
    exit 0
fi
