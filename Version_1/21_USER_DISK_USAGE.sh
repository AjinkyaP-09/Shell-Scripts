#!/bin/bash

read -p "Give user name: " USERNAME
USER_HOME="$(eval echo ~$USERNAME)"
TOTAL_USAGE=$(du -sh "$USER_HOME" 2>/dev/null | grep -E '^[0-9.]+[KMG]' | awk '{print $1}')

if [ -z "$TOTAL_USAGE" ]; then
    echo "Could not determine disk usage for user '$USERNAME'."
else
    echo "Total disk space used by user '$USERNAME': $TOTAL_USAGE"
fi
