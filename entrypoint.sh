#! /bin/bash

[[ -z "$LETSENCRYPT_CERT_FOLDER" ]] && LETSENCRYPT_CERT_FOLDER=/etc/letsencrypt

/certbot-traefik-json.sh

crond -f