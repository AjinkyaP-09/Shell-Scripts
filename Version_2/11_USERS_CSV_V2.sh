#####################################################################
# Script Name : 11_USERS_CSV_V2.sh
# Version 2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Add users listed in CSV file to the system
####################################################################

#!/bin/bash

CSVFILE=$1

if (($EUID != 0)); then
    echo "This script must be run as root." 1>&2
    exit 1
fi

if [[ $# != 1 ]]; then
    echo "Usage: $0 CSVFILE_PATH"
    exit 1
else
    if [ ! -f "$CSVFILE" ]; then
        echo "Error: CSV file not found or mentioned path is not a file!!"
        exit 1
    fi
    while IFS="," read -r username shell; do
        useradd -m -s "$shell" "$username"

        echo "User $username created with home directory."
    done <"$CSVFILE"
fi
