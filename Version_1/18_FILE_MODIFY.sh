#!/bin/bash
FILE="/home/ajinkya/Shell/tasks/logfilelist.txt"
DATE="$(date)"
ACTION_COMMAND="$(echo "$FILE modified at $DATE." >/home/ajinkya/Shell/tasks/modcheck.txt)"
POLLING_INTERVAL=5

LAST_MOD_TIME=$(stat -c %Y "$FILE")
while true; do
    sleep "$POLLING_INTERVAL"
    CURRENT_MOD_TIME=$(stat -c %Y "$FILE")
    if [[ "$CURRENT_MOD_TIME" -gt "$LAST_MOD_TIME" ]]; then
        #echo "File has been modified!"
        eval "$ACTION_COMMAND"
        LAST_MOD_TIME="$CURRENT_MOD_TIME"
    fi
done
