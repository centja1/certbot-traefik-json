#! /bin/bash
LETSENCRYPT_CERT_FOLDER="${LETSENCRYPT_CERT_FOLDER:-/etc/letsencrypt}"
TRAEFIK_CERT_JSON_FILE="${TRAEFIK_CERT_JSON_FILE:-$LETSENCRYPT_CERT_FOLDER/traefik-tls.json}"

echo "LETSENCRYPT_CERT_FOLDER = ${LETSENCRYPT_CERT_FOLDER}"
echo "TRAEFIK_CERT_JSON_FILE = ${TRAEFIK_CERT_JSON_FILE}"

# ensure folders exist
mkdir -p $LETSENCRYPT_CERT_FOLDER
mkdir -p $(dirname $TRAEFIK_CERT_JSON_FILE)

jsonOutput='{ "tls": { "certificates": [] } }'

for folder in $LETSENCRYPT_CERT_FOLDER/live/*; do
    if [[ -f $folder/privkey.pem && -f $folder/fullchain.pem ]]; then
        echo "Found certificates in $folder"
        jsonOutput=$(echo "$jsonOutput" | jq -r ".tls.certificates[.tls.certificates| length] |= . + { \"certFile\": \"$folder/fullchain.pem\", \"keyFile\": \"$folder/privkey.pem\" }")
    fi
done;

jq -r <<< "$jsonOutput" > ${TRAEFIK_CERT_JSON_FILE}
