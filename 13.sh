###################################################################################
#     Script Name   :  create_vhost.sh                                            #
#     Version       :  1.0                                                       #
#     Date          :  22 Oct 2025                                               #
#     Credit        :  Team CloudEthix                                           #
#     Purpose       :  Shell script to create an Apache virtual host for a domain #
#                        and reload Apache safely.                               #
###################################################################################


#!/bin/bash


if [ "$EUID" -ne 0 ]; then
    echo " Please run this script as root."
    exit 1
fi


DOMAIN=$1

DIR="/var/www/$DOMAIN"
CONF="/etc/httpd/conf.d/$DOMAIN.conf"


if ! mkdir -p "$DIR"; then
    echo " Failed to create directory $DIR."
    exit 1
fi


echo "$DOMAIN is live!" > "$DIR/index.html" || { 
    echo " Failed to create index.html in $DIR"; 
    exit 1; 
}

if ! cat > "$CONF" <<EOF
<VirtualHost *:80>
    ServerName $DOMAIN
    DocumentRoot $DIR
</VirtualHost>
EOF
then
    echo " Failed to write config file $CONF."
    exit 1
fi


if systemctl reload httpd; then
    echo " $DOMAIN virtual host created and Apache reloaded successfully!"
else
    echo " Failed to reload Apache. Please check the configuration."
    exit 1
fi
