# Write a shell script that checks for software updates and installs them automatically.

#####################################################################
# Script Name : 05_SOFT_UPDTE.sh
# Version :2.0
# Date : 20 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check for softwarte updates and update software if available.
####################################################################

#!/bin/bash

if (($EUID != 0)); then
    echo "This script must be run as root." 1>&2
    exit 1
else

    echo "Checking for updates..."

    CHECK_UPDATE="$(yum check-update)"

    if (($? == 100)); then
        echo "Updates available."
        echo "Installing the updates..."

        yum update -y >/dev/null 2>&1

        echo "Updates installed."
    else
        echo "There are no updates. All softwares are updated."
    fi
fi
