#####################################################################
# Script Name : 17_SSH_LOGIN_FAILURE_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get failed SSH Logins on a server.
####################################################################

#!/bin/bash

function SSH_REPORT_EMAIL() {
    echo -e "Hello All, 
   This is system generated email, do not reply to this email.
   
   We have found failed SSH attempts on $(ifconfig | grep inet | head -n 1 | awk '{print $2}')

   Kindly take necessary action ASAP to avoid future inconvenience.
   
   Server Name : - $(hostname)
   Server IP :- $(ifconfig | grep inet | head -n 1 | awk '{print $2}')
   
   Thank & Regards,
   Team CloudEthix"
}

OUTPUT_FILE="$1"
LOG_FILE="/var/log/secure"

if [[ $# != "1" ]]; then
    echo "Usage: $0 OUTPUT_FILE_PATH"
    exit 1
fi

if [[ $EUID != "0" ]]; then
    echo "Error: Root privileges are required to read $LOG_FILE."
    exit 1
else
    echo "Searching for failed login attempts in $LOG_FILE..."
    grep 'Failed password' "$LOG_FILE" >"$OUTPUT_FILE"
    echo "Done. Results saved to $OUTPUT_FILE"
    echo "Generating report and sending over email..."
    SSH_REPORT_EMAIL
    exit 0
fi
