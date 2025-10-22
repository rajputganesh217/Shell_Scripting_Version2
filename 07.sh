###############################################################################
#     Script Name   :  System_usage_report.sh                               #               
#     Version       :  2.0                                                  #                 
#     Date          :  17 Oct 2025                                          #               
#     Credit        :  Team CloudEthix                                      #             
#     Purpose       :  Shell Script for Monitering System Resources and     #
#                        give report.                                       #
###############################################################################


#!/bin/bash
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
DISK=$(df -h / | awk 'NR==2 {print $5}')
UPTIME=$(uptime -p)

echo "==== SYSTEM REPORT ===="
echo "CPU Usage: $CPU%"
echo "Memory Usage: $MEMORY%"
echo "Disk Usage: $DISK"
echo "Uptime: $UPTIME"
echo ""
