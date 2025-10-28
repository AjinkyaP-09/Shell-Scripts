#####################################################################
# Script Name : 10_EC2_JSON_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get details of EC2 instance from JSON file.
####################################################################

#!/bin/bash

JSON_FILE="$1"

if [[ $# != "1" ]]; then
    echo "Usage: $0 [json_file]"
    exit 1
elif [ ! -f "$JSON_FILE" ] || [ ! -r "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found or is not readable."
    exit 1
else
    echo "Parsing EC2 instance data from '$JSON_FILE':"
    echo "Details of Instances:"
    jq -r '.Reservations[].Instances[] | "Instance ID: \(.InstanceId), Private IP: \(.PrivateIpAddress), Public IP: \(.PublicIpAddress)"' "$JSON_FILE"

    if [ $? -ne 0 ]; then
        echo "Error: 'jq' command failed. The file may be invalid JSON."
        exit 1
    else
        echo "Parsing complete."
        exit 0
    fi
fi
