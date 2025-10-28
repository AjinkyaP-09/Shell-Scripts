#####################################################################
# Script Name : 22_DAILY_SYS_LOG_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get daily logs of system in a report file.
####################################################################

#!/bin/bash
REPORT=$1
LOG_FILE="/var/log/messages"

function REPORT_MAIL() {
    echo -e "Hello All This is system generated email, do not reply to this email.

    Report on daily logs of system:
    grep "$DATE_SEARCH" "$LOG_FILE"

    Thank & Regards
    Team CloudEthix"
}

if [[ $# != "1" ]]; then
    echo "Usage: $0 REPORT_FILE"
    exit 1
elif [ ! -r "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found or is not readable."
    echo "Note: You may need root privileges."
    exit 1
else

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
    REPORT_MAIL
    echo "Search complete. Logs are written to report file $REPORT"
    exit 0
fi
