#####################################################################
# Script Name : 13_VIRTUAL_HOST_V3.sh
# Version :3.0
# Date : 28 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Create a simple Apache (httpd) virtual host.
####################################################################

#!/bin/bash
DOMAIN="$1"
WWW_ROOT="/var/www"
APACHE_CONFIG_DIR="/etc/httpd/conf.d"

function STATUS_CHECK() {
    if [[ $? != "0" ]]; then
        echo "Failed!"
        exit 1
    fi
    echo "Done."
}

if [[ $# != "1" ]]; then
    echo "Usage: $0 DOMAIN_NAME"
    exit 1
fi

if [[ $EUID != "0" ]]; then
    echo "Error: This script must be run as root."
    exit 1
else
    DOC_ROOT_DIR="$WWW_ROOT/$DOMAIN"
    CONF_FILE="$APACHE_CONF_DIR/$DOMAIN.conf"

    echo "Creating new virtual host for $DOMAIN..."

    echo -n "Creating document root at $DOC_ROOT_DIR..."
    mkdir -p "$DOC_ROOT_DIR"

    STATUS_CHECK

    echo -n "Creating dummy index.html..."
    echo "<h1>$DOMAIN is live!</h1>" >"$DOC_ROOT_DIR/index.html"

    STATUS_CHECK

    echo -n "Creating Apache config at $CONF_FILE..."
    cat >"$CONF_FILE" <<EOF
<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot $DOC_ROOT_DIR
    <Directory "$DOC_ROOT_DIR">
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog /var/log/httpd/${DOMAIN}_error.log
    CustomLog /var/log/httpd/${DOMAIN}_access.log combined
</VirtualHost>
EOF

    STATUS_CHECK

    echo -n "Testing Apache configuration..."
    if ! httpd -t &>/dev/null; then
        echo "Failed! Configuration test failed. Please check 'httpd -t'."
        rm -f "$CONF_FILE"
        exit 1
    fi
    echo "Done."

    echo -n "Reloading httpd service..."
    if ! systemctl reload httpd &>/dev/null; then
        echo "Failed! Could not reload httpd."
        exit 1
    fi
    echo "Done."

    echo "Virtual host for $DOMAIN created successfully!"
    exit 0
fi
