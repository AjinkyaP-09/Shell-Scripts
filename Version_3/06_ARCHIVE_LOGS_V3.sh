# Write a script that compresses and archives log files older than a certain number of days.

#####################################################################
# Script Name : 06_ARCHIVE_LOGS_V2.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Compress and archive log files older than specific number of days.
####################################################################

#!/bin/bash
DAYS=$1
LOCATION=/tmp/logarchives/

function ARCHIVE() {
    find /var/log/*.log -mtime +$DAYS | while read -r filename; do

        base_filename=$(basename "$filename")

        echo "Archiving file $filename..."
        tar -czf "$LOCATION/$base_filename.tar.gz" "$filename"

    done
}

if (($# != 1)); then
    echo "Usage: $0 DAYS"
    exit 1
else
    echo "Compressing and archiving files older than $DAYS days..."
    mkdir -p "$LOCATION"
    ARCHIVE
    echo "Tar files saved at $LOCATION"
    exit 0
fi
