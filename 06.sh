###############################################################################
#     Script Name   :  Days_old_log_archive.sh                                 #               
#     Version       :  2.0                                                     #                 
#     Date          :  17 Oct 2025                                             #               
#     Credit        :  Team CloudEthix                                         #             
#     Purpose       :  Shell script to archive the logs for given days old     #
#                                                                              #
###############################################################################



#!/bin/bash

LOG_DIR=$1
DAYS_OLD=$2
ARCHIVE_DIR="$LOG_DIR/archive"


if [[ $# -ne 2 ]]; then
    echo " Error: Missing arguments."
    echo "Usage: $0 LOG_DIR DAYS_OLD"
    exit 1
fi

if [[ ! -d "$LOG_DIR" ]]; then
    echo " Error: Source directory '$LOG_DIR' does not exist."
    exit 1
fi

mkdir -p "$ARCHIVE_DIR"
tar -czf "$ARCHIVE_DIR/logs_$(date +%Y-%m-%d).tar.gz" $(find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS_OLD)
find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS_OLD -exec rm -f {} \;
echo 
echo " Archiving of Logs Completed"
