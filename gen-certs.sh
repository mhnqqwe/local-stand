#!/usr/bin/env bash
set -euo pipefail

DOMAIN="${1:-localhost}"
CERTS_DIR="$(cd "$(dirname "$0")" && pwd)/certs"
mkdir -p "$CERTS_DIR"

echo "Генерируем сертификат для: $DOMAIN"

openssl req -x509 \
    -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERTS_DIR/server.key" \
    -out    "$CERTS_DIR/server.crt" \
    -subj   "/C=RU/ST=Local/L=Local/O=Dev/OU=DevOps/CN=$DOMAIN" \
    -addext "subjectAltName=DNS:$DOMAIN,DNS:localhost,IP:127.0.0.1"

chmod 600 "$CERTS_DIR/server.key"
echo "Сертификат готов: $CERTS_DIR/"
