#!/bin/sh
set -e

# Read the Postgres password from the Docker secret
export POSTGRES_PASSWORD=$(cat /run/secrets/VAULTWARDEN_POSTGRES_PASSWORD)
export DATABASE_URL="postgresql://vaultwarden:${POSTGRES_PASSWORD}@vaultwarden-db/vaultwarden"

exec /start.sh
