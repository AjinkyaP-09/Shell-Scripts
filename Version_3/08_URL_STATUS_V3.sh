#####################################################################
# Script Name : 08_URL_STATUS_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check if mentioned URL is working fine (is up) or not.
####################################################################

#!/bin/bash
SITE=$1

function SITE_DOWN() {
    echo -e "
    Hello All This is system generated email, do not reply to this email.

    The website $SITE is DOWN.
    Kindly check the servers of $SITE. 
    
    Message from:
    Server Name : - $(hostname)
    Server IP :- $(ifconfig | grep inet | head -n 1 | awk '{print $2}')
    
    Thank & Regards
    Team CloudEthix"
}

if (($# != "1")); then
    echo "Usage $0 SITE(https://url)"
    exit 1
else
    echo "Checking Status of the website $SITE..."
    STATUS_CODE="$(curl -Is $SITE | head -n 1 | awk '{print $2}')"
    if ((STATUS_CODE != 200)); then
        SITE_DOWN
    else
        echo "$SITE is up"
    fi
    exit 0
fi
