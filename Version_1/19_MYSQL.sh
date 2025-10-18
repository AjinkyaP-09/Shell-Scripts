#!/bin/bash
read -p "Enter user name: " USERNAME
read -p "Enter password for user: " PASSWD
read -p "Enter db name: " DB
DATE="$(date +%Y%m%d%H%M%S)"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$USERNAME'@'localhost' identified by '$PASSWD';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT CREATE ON *.* TO '$USERNAME'@'localhost';"
mysql -u root -p$MYSQ_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB.* TO '$USERNAME'@'localhost';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
mysql -u $USERNAME -p$PASSWD -e "CREATE DATABASE $USERNAME$DATE;"
