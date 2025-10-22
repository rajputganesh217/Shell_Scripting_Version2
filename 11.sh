###############################################################################
#     Script Name   :  create_usr_fr_csv.sh                                #               
#     Version       :  2.0                                                    #                 
#     Date          :  17 Oct 2025                                            #               
#     Credit        :  Team CloudEthix                                        #             
#     Purpose       :  Shell script for creating users using names that are   #
#                            present in given csv file.                       #
###############################################################################


#!/bin/bash

CSV_FILE=$1


if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: File '$CSV_FILE' not found."
    exit 1
fi

while IFS="," read -r name lastname; do
    if [[ -z "$name" || -z "$lastname" ]]; then
        echo "Skipping invalid line: '$name,$lastname'"
        continue
    fi
    
    if useradd -m -c "$lastname" "$name" 2>/dev/null; then
        echo "User '$name' created successfully."
    else
        echo "Failed to create user '$name' (might already exist)."
    fi
done < "$CSV_FILE"


