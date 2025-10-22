###################################################################################
#     Script Name   :  Check_Dir_Diff.sh                                         #
#     Version       :  1.0                                                       #
#     Date          :  22 Oct 2025                                               #
#     Credit        :  Team CloudEthix                                           #
#     Purpose       :  Shell script to check difference between  given two       #
#                           directories .                                        #
###################################################################################

#!/bin/bash

DIR1=$1
DIR2=$2



if [[ $# -ne 2 ]]; then
    echo "Usage: $0 DIR1 DIR2"
    exit 1
fi

if [[ ! -d "$DIR1" ]]; then
    echo "Error: Directory '$DIR1' does not exist."
    exit 1
fi

if [[ ! -d "$DIR2" ]]; then
    echo "Error: Directory '$DIR2' does not exist."
    exit 1
fi

diff -q "$DIR1" "$DIR2"

if diff -q "$DIR1" "$DIR2" >/dev/null; then
        echo "There is no difference between the directories."
    else
        echo "There is a difference between the directories."
 fi