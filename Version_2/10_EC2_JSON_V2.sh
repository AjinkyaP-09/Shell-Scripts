#####################################################################
# Script Name : 10_EC2_JSON_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Get details of EC2 instance from JSON file.
####################################################################

#!/bin/bash

JSON_FILE="$1"

if [[ $# != "1" ]]; then
    echo "Usage: $0 [json_file]"
    exit 1
fi

if [ ! -f "$JSON_FILE" ] || [ ! -r "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found or is not readable."
    exit 1
fi

echo "Parsing EC2 instance data from '$JSON_FILE':"

jq -r '.Reservations[].Instances[] | "Instance ID: \(.InstanceId), Private IP: \(.PrivateIpAddress), Public IP: \(.PublicIpAddress)"' "$JSON_FILE"

if [ $? -ne 0 ]; then
    echo "Error: 'jq' command failed. The file may be invalid JSON."
    exit 1
fi

echo "Parsing complete."
exit 0
