###########################################################################################
#     Script Name   :  Daily_Log_Email.sh                                                #
#     Version       :  1.0                                                               #
#     Date          :  22 Oct 2025                                                       #
#     Credit        :  Team CloudEthix                                                   #
#     Purpose       :  Shell script to send the last 15 lines of /var/log/messages       #
#                    as a daily system log summary to a specified email address.         #
#                                                                                        #
#     Usage         :  ./Daily_Log_Email.sh <email_address>                              #
#                                                                                        #
#     Example       :  ./Daily_Log_Email.sh testuser@gmail.com                           #
#                     # Sends the last 15 lines of system log to testuser@gmail.com      #
###########################################################################################





#!/bin/bash


if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <email_address>"
    exit 1
fi

EMAIL=$1
SUBJECT="Daily System Log Summary - $(date '+%Y-%m-%d')"
LOG_FILE="/var/log/messages"


if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

if tail -n 15 "$LOG_FILE" | mail -s "$SUBJECT" "$EMAIL"; then
    echo " Daily log summary sent to $EMAIL."
else
    echo " Failed to send log summary to $EMAIL. Check mail configuration."
    exit 1
fi
