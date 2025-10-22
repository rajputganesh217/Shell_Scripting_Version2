#############################################################################################
#     Script Name   :  Failed_SSH_Report.sh                                                 #
#     Version       :  1.0                                                                  #
#     Date          :  22 Oct 2025                                                          #
#     Credit        :  Team CloudEthix                                                      #
#     Purpose       :  Shell script to generate a report of failed SSH login attempts       #
#                    from the /var/log/secure file and save it to a specified output file.  #
#                                                                                           #
#     Usage         :  ./Failed_SSH_Report.sh <output_file>                                 #
#                                                                                           #
#     Example       :  ./Failed_SSH_Report.sh failed_ssh_report.txt                         #
#                     # The report will be saved in failed_ssh_report.txt                   #
#############################################################################################




#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <output_file>"
    exit 1
fi

OUTPUT_FILE=$1
LOG_FILE="/var/log/secure"


if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi


if grep -i "failed" "$LOG_FILE" > "$OUTPUT_FILE" 2>/dev/null; then
    echo " Result stored in '$OUTPUT_FILE'"
else
    echo "  Error occurred while creating the report."
    exit 1
fi
