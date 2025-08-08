#!/bin/bash

# Check if domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
WWW_DOMAIN="www.$DOMAIN"
WEBROOT="/home/$DOMAIN/public_html"
KEY_PATH="/etc/letsencrypt/live/$DOMAIN/privkey.pem"
FULLCHAIN_PATH="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

echo "=== Issuing SSL certificate for $DOMAIN and $WWW_DOMAIN ==="
~/.acme.sh/acme.sh --issue -d "$DOMAIN" -d "$WWW_DOMAIN" --webroot "$WEBROOT" --force

echo "=== Installing SSL certificate ==="
~/.acme.sh/acme.sh --install-cert -d "$DOMAIN" --ecc \
--key-file "$KEY_PATH" \
--fullchain-file "$FULLCHAIN_PATH" \
--reloadcmd "systemctl restart lsws"

echo "=== SSL setup complete for $DOMAIN ==="
