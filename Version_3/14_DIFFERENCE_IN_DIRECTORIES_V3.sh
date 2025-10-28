#####################################################################
# Script Name : 14_DIFFERENCE_IN_DIRECTORIES_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Compare difference in two directories recursively.
####################################################################

#!/bin/bash

DIR1="$1"
DIR2="$2"

if [[ $# != "2" ]]; then
    echo "Usage: $0 [directory_1] [directory_2]"
    exit 1
fi

if [[ ! -d "$DIR1" || ! -d "$DIR2" ]]; then
    echo "Error: Directory '$DIR1' or '$DIR2' not found."
    exit 1
else

    echo "Comparing '$DIR1' and '$DIR2'..."

    DIFF_OUTPUT=$(diff -rq "$DIR1" "$DIR2")
    DIFF_STATUS=$?

    if [[ $DIFF_STATUS == "0" ]]; then
        echo "Success: No differences found."
    elif [[ $DIFF_STATUS == "0" ]]; then
        echo "Differences found:"
        echo "$DIFF_OUTPUT"
    else
        echo "Error: An error occurred during the comparison."
        [ -n "$DIFF_OUTPUT" ] && echo "$DIFF_OUTPUT"
        exit 1
    fi

    exit 0
fi
