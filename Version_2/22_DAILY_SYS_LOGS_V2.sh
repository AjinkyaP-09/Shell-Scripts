#####################################################################
# Script Name : 22_DAILY_SYS_LOG_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get daily logs of system in a report file.
####################################################################

#!/bin/bash
REPORT=$1
LOG_FILE="/var/log/messages"

if [[ $# != "1" ]]; then
    echo "Usage: $0 REPORT_FILE"
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found or is not readable."
    echo "Note: You may need root privileges."
    exit 1
fi

DATE_SEARCH="$(date -d "today" +%b" "%_d)"

echo "Searching for logs from '$DATE_SEARCH' in '$LOG_FILE'..."

OUTPUT=$(grep "$DATE_SEARCH" "$LOG_FILE" >$REPORT 2>&1)
GREP_STATUS=$?

if [ $GREP_STATUS -eq 0 ]; then
    echo "$OUTPUT"
elif [ $GREP_STATUS -eq 1 ]; then
    echo "No logs found for '$DATE_SEARCH'."
else
    echo "Error: grep command failed."
    exit 1
fi

echo "Search complete. Logs are written to report file $REPORT"
exit 0
