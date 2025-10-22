###############################################################################
#     Script Name   :  check_site_status.sh                                 #               
#     Version       :  2.0                                                  #                 
#     Date          :  17 Oct 2025                                          #               
#     Credit        :  Team CloudEthix                                      #             
#     Purpose       :  Shell Script for checking the staus of site using    #
#                           curl.                                           #
###############################################################################


#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Usage: $0 <website_url>"
    echo "Example: $0 www.google.com"
    exit 1
fi
SITE=$1
if [[ "$SITE" != http* ]]; then
    SITE="https://$SITE"
fi

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -L "$SITE")

if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 400 ]; then
    echo "$SITE is UP (HTTP $HTTP_CODE)"
else
    echo "$SITE is Down (HTTP $HTTP_CODE)"
fi
