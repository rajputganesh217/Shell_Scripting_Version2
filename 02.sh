
################################################################################
#     Script Name   :  check_disk_usage.sh                                     #               
#     Version       :  2.0                                                     #                 
#     Date          :  17 Oct 2025                                             #               
#     Credit        :  Team CloudEthix                                         #             
#     Purpose       :  A shell script to check the disk utilisation of server. #                                                                           
###############################################################################


#!/bin/bash

THRESHOLD=$1

if [[ $# -ne 1 ]]; then
    echo " Error: Missing argument."
    echo "Usage: $0 <THRESHOLD>"
    exit 1
fi

if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]] || [[ "$THRESHOLD" -lt 1 ]] || [[ "$THRESHOLD" -gt 100 ]]; then
    echo " Error: Threshold must be a number between 1 and 100."
    exit 1
fi

PARTITIONS=$(df -h --output=source,target,pcent | grep -vE 'tmpfs|loop' | tail -n +2)

if [[ $? -ne 0 ]]; then
    echo " Error: Failed to retrieve disk usage information."
    exit 1
fi

ALERT=0

echo "Disk usage report on $(hostname):"

while read -r line; do
    DEVICE=$(echo $line | awk '{print $1}')
    MOUNT=$(echo $line | awk '{print $2}')
    USAGE=$(echo $line | awk '{print $3}' | sed 's/%//')

    if [[ "$USAGE" -ge "$THRESHOLD" ]]; then
        echo " WARNING: $MOUNT ($DEVICE) usage is at ${USAGE}%"
        ALERT=1
    else
        echo " $MOUNT ($DEVICE) usage is normal: ${USAGE}%"
    fi
done <<< "$PARTITIONS"

echo "----------------------------------------"
if [[ $ALERT -eq 1 ]]; then
    echo " One or more partitions exceed the threshold of ${THRESHOLD}%!"
else
    echo " All partitions are below the threshold of ${THRESHOLD}%."
fi
