###################################################################################################
#     Script Name   :  Rename_Files.sh                                                            # 
#     Version       :  1.0                                                                        #
#     Date          :  22 Oct 2025                                                                #
#     Credit        :  Team CloudEthix                                                            #
#     Purpose       :  Shell script to rename all files in a specified directory using            #
#                    a new base name with incremental numbering while preserving file extensions. #
#                                                                                                 #
#     Usage         :  ./Rename_Files.sh <directory> <new_base_name>                              #
#                                                                                                 #
#     Example       :  ./Rename_Files.sh /home/user/docs report                                   #
#                     # Renames files in /home/user/docs to report1.ext, report2.ext, etc.        #
###################################################################################################

#!/bin/bash


if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <directory> <new_base_name>"
    exit 1
fi

DIR=$1
BASE=$2


if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

COUNT=1


for FILE in "$DIR"/*; do
    if [[ -f "$FILE" ]]; then
        EXT="${FILE##*.}"
        NEW_NAME="$DIR/$BASE$COUNT.$EXT"
        if mv "$FILE" "$NEW_NAME" 2>/dev/null; then
            echo " Renamed: $FILE -> $NEW_NAME"
            ((COUNT++))
        else
            echo " Failed to rename: $FILE"
        fi
    fi
done

echo " All files renamed successfully in '$DIR'."
