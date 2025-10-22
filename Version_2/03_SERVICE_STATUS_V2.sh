# Write a shell script that checks whether a specified service is running
# and restarts it if it's not running.

#####################################################################
# Script Name : 03_SERVICE_STATUS_V2.sh
# Version :2.0
# Date : 20 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check if a service is running and if not then restart.
####################################################################

#!/bin/bash
SERVICE=$1

function run_service() {
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is running."
    else
        echo "$SERVICE is not running. Attempting to restart..."
        systemctl restart "$SERVICE"
        if systemctl is-active --quiet "$SERVICE"; then
            echo "Successfully restarted $SERVICE."
        else
            echo "Failed to restart $SERVICE. See details below."
            systemctl status "$SERVICE" --no-pager
        fi
    fi
}

if [[ $# != 1 ]]; then
    echo "Usage: $0 SERVICE"
else
    systemctl show --no-pager $SERVICE.service | grep LoadState=loaded >/dev/null
    if (($? == 0)); then
        run_service
    else
        echo "Service not present"
    fi
fi
