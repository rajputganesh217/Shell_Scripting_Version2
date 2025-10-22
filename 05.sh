
###############################################################################
#     Script Name   :  update_software.sh                                     #               
#     Version       :  2.0                                                    #                 
#     Date          :  17 Oct 2025                                            #               
#     Credit        :  Team CloudEthix                                        #             
#     Purpose       :  A shell script program to update the software like     #
#                      Nginx Apache .                                         #
###############################################################################


#!/bin/bash

SERVICE=$1

if [[ -z "$SERVICE" ]]; then
    echo " Error: Missing service name."
    echo "Usage: $0 <service_name>"
    exit 1
fi

if ! command -v systemctl &>/dev/null; then
    echo " Error: systemctl command not found on this system."
    exit 1
fi
if ! systemctl list-unit-files | grep -qw "$SERVICE.service"; then
    echo " Error: Service '$SERVICE' does not exist."
    exit 1
fi

if command -v yum &>/dev/null; then
    PKG_MGR="yum"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
elif command -v apt &>/dev/null; then
    PKG_MGR="apt"
else
    echo " Error: No supported package manager found (yum/dnf/apt)."
    exit 1
fi

echo " Starting update for $SERVICE using $PKG_MGR..."

if [[ "$PKG_MGR" == "apt" ]]; then
    sudo apt update -y &>/dev/null
    sudo apt install --only-upgrade "$SERVICE" -y &>/dev/null
else
    sudo $PKG_MGR update "$SERVICE" -y &>/dev/null
fi

if [[ $? -eq 0 ]]; then
    echo " Update of $SERVICE completed successfully."
else
    echo " Update failed. Please check manually."
    exit 1
fi

echo " Update process finished."
