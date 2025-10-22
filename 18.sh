###########################################################################################
#     Script Name   :  Monitor_File.sh                                                    #
#     Version       :  1.0                                                                #
#     Date          :  22 Oct 2025                                                        #
#     Credit        :  Team CloudEthix                                                    #
#     Purpose       :  Shell script to monitor a specified file for modifications.        #
#                    It supports two approaches:                                          #
#                      1) Real-time monitoring using inotifywait                          #
#                      2) Periodic checking using stat                                    #
#                                                                                         #
#     Usage         :  ./Monitor_File.sh <file_to_monitor>                                #
#                                                                                         #
#     Example       :  ./Monitor_File.sh /home/user/test.txt                              #
#                     # Monitors test.txt for modifications and prints change events      #
###########################################################################################

#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file_to_monitor>"
    exit 1
fi

FILE=$1

if [[ ! -f "$FILE" ]]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

echo "Watching for changes in $FILE..."
inotifywait -m -e modify "$FILE" --format '%T %e' --timefmt '%H:%M:%S' |
while read time event; do
    echo "[$time] File modified! Event: $event"
done


:<<'comment' 
#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file_to_monitor>"
    exit 1
fi

FILE=$1

if [[ ! -f "$FILE" ]]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

LAST_MOD=$(stat -c %Y "$FILE")

echo "Monitoring $FILE for changes..."
while true; do
    sleep 2
    NEW_MOD=$(stat -c %Y "$FILE")
    if [[ "$NEW_MOD" != "$LAST_MOD" ]]; then
        echo "[$(date +%H:%M:%S)] File modified!"
        LAST_MOD=$NEW_MOD
    fi
done
comment 