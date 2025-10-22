###########################################################################################
#     Script Name   :  Weather_Check.sh                                                   #
#     Version       :  1.0                                                                #
#     Date          :  22 Oct 2025                                                        #
#     Credit        :  Team CloudEthix                                                    #
#     Purpose       :  Shell script to fetch the current weather summary for a specified  #
#                    city using the wttr.in service.                                      #
#                                                                                         #
#     Usage         :  ./Weather_Check.sh <city_name>                                     #
#                                                                                         #
#     Example       :  ./Weather_Check.sh London                                          #
#                     # Fetches and displays the current weather summary for London       #
###########################################################################################

#!/bin/bash


if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <city_name>"
    exit 1
fi

CITY=$1


WEATHER=$(curl -s "https://wttr.in/${CITY}?format=3" 2>/dev/null)

if [[ $? -eq 0 && -n "$WEATHER" ]]; then
    echo " Weather for $CITY: $WEATHER"
else
    echo " Failed to fetch weather for '$CITY'. Please check your internet connection or city name."
    exit 1
fi
