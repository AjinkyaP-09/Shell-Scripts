#####################################################################
# Script Name : 17_SSH_LOGIN_FAILURE_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get failed SSH Logins on a server.
####################################################################

#!/bin/bash

OUTPUT_FILE="$1"
LOG_FILE="/var/log/secure"

if [[ $EUID != "0" ]]; then
    echo "Error: Root privileges are required to read $LOG_FILE."
    exit 1
fi

if [[ $# != "1" ]]; then
    echo "Usage: $0 OUTPUT_FILE_PATH"
    exit 1
fi

if ! touch "$OUTPUT_FILE" 2>/dev/null; then
    echo "Error: Cannot write to output file '$OUTPUT_FILE'."
    exit 1
fi

echo "Searching for failed login attempts in $LOG_FILE..."

grep 'Failed password' "$LOG_FILE" >"$OUTPUT_FILE"

echo "Done. Results saved to $OUTPUT_FILE"

exit 0
