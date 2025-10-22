##############################################################################################
#     Script Name   :  User_Disk_Usage.sh                                                    #
#     Version       :  1.0                                                                   #
#     Date          :  22 Oct 2025                                                           #
#     Credit        :  Team CloudEthix                                                       #
#     Purpose       :  Shell script to calculate the total disk space used by a specific     #
#                    user on the system.                                                     #
#                                                                                            #
#     Usage         :  ./User_Disk_Usage.sh <username>                                       #
#                                                                                            #
#     Example       :  ./User_Disk_Usage.sh ganesh                                           #
#                     # Displays total disk usage by user 'ganesh' in human-readable format  #
##############################################################################################



#!/bin/bash


if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1


if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi


TOTAL_USAGE=$(find / -user "$USERNAME" -type f -exec du -b {} + 2>/dev/null | awk '{sum += $1} END {print sum}')


HUMAN_READABLE=$(numfmt --to=iec --suffix=B "$TOTAL_USAGE" 2>/dev/null)

echo
echo " Total disk space used by user '$USERNAME': $HUMAN_READABLE"
