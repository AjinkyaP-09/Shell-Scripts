#!/bin/bash
read -p "Enter the service to check: " SERVICE

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

systemctl show --no-pager $SERVICE.service | grep LoadState=loaded >/dev/null
if (($? == 0)); then
    run_service
else
    echo "Service not present"
fi
