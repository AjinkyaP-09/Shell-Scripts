#####################################################################
# Script Name : 19_MYSQL_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Allow creation of new user and access to database.
####################################################################

#!/bin/bash

NEW_USER="$1"
NEW_PASS="$2"
NEW_DB="$3"

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [new_username] [new_password] [db_name]"
    exit 1
fi

if ! command -v mysql &>/dev/null; then
    echo "Error: 'mysql' client not found."
    echo "Please install it (e.g., 'yum install mysql')."
    exit 1
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "Error: MYSQL_ROOT_PASSWORD environment variable is not set."
    echo "Usage: MYSQL_ROOT_PASSWORD='your_pass' $0 $@"
    exit 1
fi

echo "Attempting to create user '$NEW_USER' and database '$NEW_DB'..."

DATE=$(date +%Y%m%d%H%M%S)

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$NEW_USER'@'localhost' IDENTIFIED BY '$NEW_PASS';"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create user. Does user already exist?"
    exit 1
fi

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT CREATE ON *.* TO '$NEW_USER'@'localhost';"
if [ $? -ne 0 ]; then
    echo "Error: Failed to grant CREATE permission."
    exit 1
fi

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $NEW_DB.* TO '$NEW_USER'@'localhost';"
if [ $? -ne 0 ]; then
    echo "Error: Failed to grant privileges on database."
    exit 1
fi

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "User '$NEW_USER' created successfully."

echo "Creating default database ${NEW_DB}..."
mysql -u "$NEW_USER" -p"$NEW_PASS" -e "CREATE DATABASE $NEW_DB;"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create database '$NEW_DB' as new user."
    exit 1
fi

echo "Database '$NEW_DB' created successfully."
echo "All operations complete."
exit 0
