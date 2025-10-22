#####################################################################
# Script Name : 08_URL_STATUS_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check if mentioned URL is working fine (is up) or not.
####################################################################

#!/bin/bash
SITE=$1
if (($# != "1")); then
    echo "Usage $0 SITE(https://url)"
    exit 1
else
    STATUS_CODE="$(curl -Is $SITE | head -n 1 | awk '{print $2}')"
    if ((STATUS_CODE != 200)); then
        echo "$SITE is down"
    else
        echo "$SITE is up"
    fi
fi
