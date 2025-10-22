#####################################################################
# Script Name : 18_FILE_MODIFICATION_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Monitor a file's modification every 5 seconds.
####################################################################

#!/bin/bash

FILE="$1"
LOG_FILE="$2"
POLLING_INTERVAL=5

if [[ $# != "2" ]]; then
    echo "Usage: $0 [FILE] [log_file]"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

if ! touch "$LOG_FILE" 2>/dev/null; then
    echo "Error: Cannot write to log file '$LOG_FILE'."
    exit 1
fi

echo "Watching '$FILE' for modifications..."
echo "Press [CTRL+C] to stop."

LAST_MOD_TIME=$(stat -c %Y "$FILE")

while true; do
    sleep "$POLLING_INTERVAL"

    CURRENT_MOD_TIME=$(stat -c %Y "$FILE")

    if [[ "$CURRENT_MOD_TIME" > "$LAST_MOD_TIME" ]]; then
        DATE=$(date)
        echo "File '$FILE' was modified at $DATE."

        echo "File modified at $DATE." >>"$LOG_FILE"

        LAST_MOD_TIME="$CURRENT_MOD_TIME"
    fi
done
