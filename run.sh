#!/usr/bin/env bash

set -euo pipefail

# Load environment variables
if [[ -f .env ]]; then
  set -a
  source .env
  set +a
else
  echo "Error: .env file not found." >&2
  exit 1
fi

# Check for openssl
if ! command -v openssl >/dev/null 2>&1; then
  echo "Error: openssl is not installed. Please install it (sudo apt update && sudo apt install openssl) and try again." >&2
  exit 1
fi

# Check for argon2
if ! command -v argon2 >/dev/null 2>&1; then
  echo "Error: argon2 is not installed. Please install it (sudo apt update && sudo apt install argon2) and try again." >&2
  exit 1
fi

# Create secrets
mkdir -p .docker/secrets

generate_secret() {
  local secret_name="$1"
  local secret_path=".docker/secrets/$secret_name"
  if [[ ! -f "$secret_path" ]]; then
    openssl rand -base64 32 | tr -dc 'A-Za-z0-9' > "$secret_path"
    chmod 600 "$secret_path"
    echo "Secret $secret_name created."
  else
    echo "Secret $secret_name already exists."
  fi
}

secrets=(
  "NEXTCLOUD_ADMIN_PASSWORD"
  "NEXTCLOUD_POSTGRES_PASSWORD"
  "NEXTCLOUD_REDIS_HOST_PASSWORD"
  "VAULTWARDEN_ADMIN_TOKEN"
  "VAULTWARDEN_POSTGRES_PASSWORD"
)

for secret in "${secrets[@]}"; do
  generate_secret "$secret"
done

# Create a secure hash of the VAULTWARDEN_ADMIN_TOKEN
if [[ ! -f ".docker/secrets/VAULTWARDEN_ADMIN_TOKEN_HASH" ]]; then
  argon2 "$(openssl rand -base64 32)" -e -id -k 19456 -t 2 -p 1 < .docker/secrets/VAULTWARDEN_ADMIN_TOKEN | sed 's#\$#\$\$#g' > ".docker/secrets/VAULTWARDEN_ADMIN_TOKEN_HASH"
  chmod 600 ".docker/secrets/VAULTWARDEN_ADMIN_TOKEN_HASH"
  echo "VAULTWARDEN_ADMIN_TOKEN_HASH created."
else
  echo "VAULTWARDEN_ADMIN_TOKEN_HASH already exists."
fi

# Deploy with docker compose
docker compose up -d
