#!/bin/bash
LOG_FILE="/var/log/messages"
DATE="$(date -d "today" +%b" "%_d)"
if grep -q "$DATE" "$LOG_FILE"; then
    echo "$(grep $DATE $LOG_FILE)"
else
    echo "No logs for yesterday"
fi
