# Write a script that compresses and archives log files older than a certain number of days.

#####################################################################
# Script Name : 06_ARCHIVE_LOGS_V2.sh
# Version :2.0
# Date : 20 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Compress and archive log files older than specific number of days.
####################################################################

#!/bin/bash
DAYS=$1
LOCATION=/tmp/logarchives/

if (($# != 1)); then
    echo "Usage: $0 DAYS"
else
    echo "Compressing and archiving files older than $DAYS days..."
    mkdir -p "$LOCATION"

    find /var/log/*.log -mtime +$DAYS | while read -r filename; do

        base_filename=$(basename "$filename")

        echo "Archiving $filename..."
        tar -czf "$LOCATION/$base_filename.tar.gz" "$filename"

    done
    echo "Tar files saved at $LOCATION"
fi
