###########################################################################################
#     Script Name   :  Search_Replace.sh                                                #
#     Version       :  1.0                                                              #
#     Date          :  22 Oct 2025                                                      #
#     Credit        :  Team CloudEthix                                                  #
#     Purpose       :  Shell script to search for a specific text in all files of a     #
#                    given directory and replace it with another text.                  #
#                                                                                       #
#     Usage         :  ./Search_Replace.sh <directory> <search_text> <replace_text>     #
#                                                                                       #
#     Example       :  ./Search_Replace.sh /home/user/docs "oldtext" "newtext"          #
#                     # Replaces all occurrences of "oldtext" with "newtext" in files   #
#                     # inside /home/user/docs                                          #
###########################################################################################


#!/bin/bash


if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <directory> <search_text> <replace_text>"
    exit 1
fi

DIR=$1
PRESENT=$2
REPLACE=$3

if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

for FILE in "$DIR"/*; do
    if [[ -f "$FILE" ]]; then
        if sed -i "s/${PRESENT}/${REPLACE}/g" "$FILE" 2>/dev/null; then
            echo " Updated: $FILE"
        else
            echo "  Failed to update: $FILE"
        fi
    fi
done

echo " Search and replace completed in directory '$DIR'."
