#####################################################################
# Script Name : 20_WEATHER_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Check for weather condition of any city.
####################################################################

#!/bin/bash

CITY="$1"

if [[ $# != "1" ]]; then
    echo "Usage: $0 [city_name]"
    exit 1
fi

echo "Fetching weather for $CITY..."

RESPONSE=$(curl -s "https://wttr.in/${CITY}?format=3")

if [[ $? != "0" ]]; then
    echo "Error: curl command failed. Check network connection."
    exit 1
fi

if [[ "$RESPONSE" == "Unknown location"* ]]; then
    echo "Error: $RESPONSE"
    exit 1
fi

echo "$RESPONSE"
exit 0
