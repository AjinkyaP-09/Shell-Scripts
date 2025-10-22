#####################################################################
# Script Name : 21_USER_DISK_USAGE_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check how much disk is used by a specific user.
####################################################################

#!/bin/bash

USERNAME="$1"

if [[ $# != "1" ]]; then
    echo "Usage: $0 [username]"
    exit 1
fi

if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

USER_HOME=$(eval echo "~$USERNAME")

if [ ! -d "$USER_HOME" ]; then
    echo "Warning: User '$USERNAME' exists, but home directory '$USER_HOME' not found."
    exit 1
fi

echo "Calculating disk usage for $USERNAME in $USER_HOME..."

TOTAL_USAGE=$(du -sh "$USER_HOME" 2>/dev/null | cut -f1)

if [[ $? != 0 ]] || [ -z "$TOTAL_USAGE" ]; then
    echo "Error: Could not determine disk usage for user '$USERNAME'."
    echo "Check read permissions for '$USER_HOME'."
    exit 1
else
    echo "Total disk space used by user '$USERNAME': $TOTAL_USAGE"
fi

exit 0
