###########################################################################################
#     Script Name   :  Create_DB_User.sh                                                   #
#     Version       :  1.0                                                                 #
#     Date          :  22 Oct 2025                                                         #
#     Credit        :  Team CloudEthix                                                     #
#     Purpose       :  Shell script to create a MySQL database and a user with full        #
#                    privileges on that database.                                          #
#                                                                                          #
#     Usage         :  ./Create_DB_User.sh <root_password> <database_name> <username>      #
#                     <user_password>                                                      #
#                                                                                          #
#     Example       :  ./Create_DB_User.sh root123 mydb myuser mypass                      #
#                     # Creates database 'mydb' and user 'myuser' with password 'mypass'   #
###########################################################################################








#!/bin/bash

if [[ $# -ne 4 ]]; then
    echo "Usage: $0 <root_password> <database_name> <username> <user_password>"
    exit 1
fi

ROOT_PASS=$1
DB_NAME=$2
DB_USER=$3
DB_PASS=$4


mysql -u root -p"$ROOT_PASS" -e "
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
" 2>/dev/null

if [[ $? -eq 0 ]]; then
    echo " Database '${DB_NAME}' and user '${DB_USER}' created successfully."
else
    echo " Failed to create database or user. Please check your root password or MySQL service."
    exit 1
fi
