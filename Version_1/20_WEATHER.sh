#!/bin/bash

read -p "Enter city name: " CITY

curl -s "https://wttr.in/${CITY}?format=3"

# #!/bin/bash

# read -p "Enter city name: " CITY

# API_KEY="2c3fa31e0118b0351114eb80c781c597"

# RESPONSE=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=metric")

# TEMP=$(echo "$RESPONSE" | jq '.main.temp')
# WEATHER=$(echo "$RESPONSE" | jq -r '.weather[0].description')

# echo
# echo "🌤 Weather in $CITY Temperature: ${TEMP}°C Condition: ${WEATHER}"
