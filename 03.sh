
############################################################################
#     Script Name   :  check_service_status.sh                             #               
#     Version       :  2.0                                                 #                 
#     Date          :  17 Oct 2025                                         #               
#     Credit        :  Team CloudEthix                                     #             
#     Purpose       :  A shell script program file to check the status of  # 
#                     service and restart if not running.                  #
###########################################################################


#!/bin/bash

SERVICE=$1

if [[ -z "$SERVICE" ]]; then
    echo " Error: Missing service name."
    echo "Usage: $0 <service_name>"
    exit 1
fi



if ! systemctl list-unit-files | grep -qw "$SERVICE.service"; then
    echo " Error: Service '$SERVICE' does not exist."
    exit 1
fi


if ! systemctl is-active --quiet "$SERVICE"; then
    echo " $SERVICE is not running. Attempting to restart..."

 if systemctl restart "$SERVICE"; then
        echo " $SERVICE has been restarted successfully."
    else
        echo " Failed to restart $SERVICE. Please check manually."
        exit 1
    fi
else
    echo " $SERVICE is running."
fi


