###################################################################################
#     Script Name   :  loc_remote_rysnc.sh                                        #               
#     Version       :  2.0                                                        #                 
#     Date          :  17 Oct 2025                                                #               
#     Credit        :  Team CloudEthix                                            #             
#     Purpose       :  Shell script for keeping synchronize a specific directory  #
#                        with a Directory on remote host.                         #
##################################################################################




#!/bin/bash

LOCAL_DIR=$1
REMOTE_PORT=$2
REMOTE_USER=$3
REMOTE_HOST_IP=$4
REMOTE_DIR=$5

if [[ $# -ne 5 ]]; then
    echo "Usage: $0 local_dir remote_port remote_user remote_host_ip remote_dir"
    exit 1
fi

if [[ ! -d "$LOCAL_DIR" ]]; then
    echo "  Local directory '$LOCAL_DIR' does not exist."
    exit 1
fi

nc -z -w5 "$REMOTE_HOST_IP" "$REMOTE_PORT"
if [[ $? -ne 0 ]]; then
    echo " Error: Cannot connect to $REMOTE_HOST_IP on port $REMOTE_PORT. Check network or firewall."
    exit 1
fi

echo " Starting rsync backup..."
rsync -avzh -e "ssh -p $REMOTE_PORT" --delete "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_HOST_IP:$REMOTE_DIR/"

if [[ $? -eq 0 ]]; then
    echo " Backup completed successfully."
else
    echo " Backup failed. Check network, permissions, or paths."
    exit 1
fi
