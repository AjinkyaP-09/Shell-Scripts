#####################################################################
# Script Name : 06.sh
# Version :1.0
# Date : 15 Oct 2025
# Credit : Team CloudEthiX
# Purpose :
####################################################################

#!/bin/bash

REPORT_FILE="$1"
DAYS_AGO="$2"
MIN_UID=1000

if [[ $# != "2" ]]; then
    echo "Usage: $0 [report_file] [days_ago]"
    exit 1
fi

if ! touch "$REPORT_FILE" 2>/dev/null; then
    echo "Error: Cannot write to report file '$REPORT_FILE'."
    exit 1
fi

if [ ! -r "/etc/passwd" ]; then
    echo "Error: Cannot read /etc/passwd."
    exit 1
fi

CUTOFF_TIME=$(date -d "$DAYS_AGO days ago" +%s)

echo "Generating report of new users (UID >= $MIN_UID) with home dirs created since $(date -d "@$CUTOFF_TIME")."
echo "Report will be saved to $REPORT_FILE"

>"$REPORT_FILE"
echo "New User Report - Generated $(date)" >>"$REPORT_FILE"
echo "Checking for users with UID >= $MIN_UID created in the last $DAYS_AGO days." >>"$REPORT_FILE"

while IFS=: read -r username _ uid gid _ homedir _; do
    if [ "$uid" -lt "$MIN_UID" ]; then
        continue
    fi

    if [ -d "$homedir" ]; then
        HOME_DIR_CTIME=$(stat -c %Z "$homedir")

        if [ "$HOME_DIR_CTIME" -gt "$CUTOFF_TIME" ]; then
            echo "Found user: $username"
            echo "User: $username (UID: $uid, Home: $homedir)" >>"$REPORT_FILE"
            echo "  Home directory ctime (created/changed): $(date -d "@$HOME_DIR_CTIME")" >>"$REPORT_FILE"
            echo "" >>"$REPORT_FILE"
        fi
    fi
done </etc/passwd

echo "Report is saved in $REPORT_FILE."
exit 0
