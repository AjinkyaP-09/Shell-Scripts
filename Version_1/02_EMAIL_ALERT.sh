#!/bin/bash
function DISK_MAIL() {
    echo -e "Hello All This is system generated email, do not reply to this email.
partitions on host $(/bin/hostname) is reached to threshold.
 Kindly take necessary action ASAP to avoid future
inconvenience.
 Server Name : - $(hostname)
 Server IP :- $(ifconfig | grep inet | head -n 1 | awk '{print $2}')
Thank & Regards
Team CloudEthix"
}

THR_VAL=30
CMND="$(df -h | grep -w '/' | awk '{print $5}' | cut -d '%' -f1)"
if (($CMND > $THR_VAL)); then
    echo -e "\n********************WARNING**********************"
    echo -e "\nYour Disk Utilization of root is Reached To Threshold $THR_VAL"
    DISK_MAIL
else
    echo "Your disk utilization is normal and current value is $CMND which is below $THR_VAL."
fi
