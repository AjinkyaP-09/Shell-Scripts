# Write a shell script to monitor disk usage and send an email alert if usage
# exceeds a specified threshold.
#####################################################################
# Script Name : 02_MONITOR_DISK_USAGE.sh
# Version :2.0
# Date : 20 Oct 2025
# Credit : Team CloudEthiX
# Purpose : This shell scripts monitors disk usage and sends email alert if usage exceeds specific
# threshold value.
####################################################################

#!/bin/bash

THR_VAL=$1

function DISK_MAIL() {
    echo -e "Hello All This is system generated email, do not reply to this email.
Partitions on host $(/bin/hostname) is reached to threshold.
 Kindly take necessary action ASAP to avoid future inconvenience.
Server Name : - $(hostname)
Server IP :- $(ifconfig | grep inet | head -n 1 | awk '{print $2}')
Thank & Regards
Team CloudEthix"
}

if [[ $# != 1 ]]; then
    echo "Usage: $0 THRESHOLD_VALUE"
else
    CMND="$(df -h | grep -w '/' | awk '{print $5}' | cut -d '%' -f1)"
    if (($CMND > $THR_VAL)); then
        echo -e "\n********************WARNING**********************"
        echo -e "\nYour Disk Utilization of root is Reached To Threshold $THR_VAL"
        DISK_MAIL
    else
        echo "Your disk utilization is normal and current value is $CMND which is below $THR_VAL."
    fi
fi
