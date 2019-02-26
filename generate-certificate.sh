#!/usr/bin/env bash
# This script generates a self signed certificate under the ./certificates directory
# Usage:
#   ./generate-certificate.sh $filename $domain
# Example:
#   ./generate-certificate.sh ANZ www.anz.com
#   ./generate-certificate.sh # will use the default values: gus www.gustavo.momenton
CERTNAME=${1:-gus}
DOMAIN=${2:-www.gustavo.momenton}

CERTDIR="$(pwd)/certificates"
TMPDIR=$(mktemp -d)
mkdir -p "${CERTDIR}"

pushd "$TMPDIR" || exit
# create key
openssl genrsa -des3 -passout pass:x -out "${CERTNAME}.pass.key" 2048
# generate pem
openssl rsa -passin pass:x -in "${CERTNAME}.pass.key" -out "${CERTNAME}.key"
# create CSR
openssl req -new -key "${CERTNAME}.key" -out "${CERTNAME}.csr" \
    -subj "/CN=${DOMAIN}/O=Momenton./C=AU"
# create crt
openssl x509 -req -sha256 -days 365 \
    -in "${CERTNAME}.csr" \
    -signkey "${CERTNAME}.key" \
    -out "${CERTDIR}/${CERTNAME}.crt"
popd || exit
