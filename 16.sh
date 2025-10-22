##############################################################################################
#     Script Name   :  Sort_Files.sh                                                         #
#     Version       :  1.0                                                                   #
#     Date          :  22 Oct 2025                                                           #
#     Credit        :  Team CloudEthix                                                       #
#     Purpose       :  Shell script to sort files in a specified directory into folders      #
#                    based on their file types (Images, Documents, Audio, Others).           #
#                                                                                            #
#     Usage         :  ./Sort_Files.sh <directory_path>                                      #
#                                                                                            #
#     Example       :  ./Sort_Files.sh /home/user/Downloads                                  #
#                     # Files in /home/user/Downloads will be sorted into type-based folders #
#############################################################################################


#!/bin/bash
DIR=$1


if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi


mkdir -p Images Documents Audio Others


for FILE in *; do
    [[ -f "$FILE" ]] || continue 

    case "$FILE" in
        *.jpg|*.png|*.gif) mv "$FILE" Images/ 2>/dev/null || echo "Failed to move $FILE";;
        *.pdf|*.txt|*.docx) mv "$FILE" Documents/ 2>/dev/null || echo "Failed to move $FILE";;
        *.mp3|*.wav) mv "$FILE" Audio/ 2>/dev/null || echo "Failed to move $FILE";;
        *) mv "$FILE" Others/ 2>/dev/null || echo "Failed to move $FILE";;
    esac
done

echo " Files have been sorted successfully in '$DIR'."
