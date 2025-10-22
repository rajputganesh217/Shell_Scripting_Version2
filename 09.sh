###############################################################################
#     Script Name   :  del_files_by_pattern.sh                                #               
#     Version       :  2.0                                                    #                 
#     Date          :  17 Oct 2025                                            #               
#     Credit        :  Team CloudEthix                                        #             
#     Purpose       :  Shell script for deleting files having specific        #
#                        pattern.                                             #
###############################################################################


#!/bin/bash
DIR=$1
PATTERN=$2

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <directory_path> <file_pattern>"
    echo "Example: $0 /var/log '*.log'"
    exit 1
fi

if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

FILES_FOUND=$(find "$DIR" -type f -name "$PATTERN")

if [[ -z "$FILES_FOUND" ]]; then
    echo " No files found matching '$PATTERN' in '$DIR'."
    exit 0
fi

find "$DIR" -type f -name "$PATTERN" -exec rm -f {} \;
echo " Files deleted successfully."
