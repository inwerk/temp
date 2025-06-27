# Load environment variables
set -a
source .env
set +a

mkdir -p .docker

mkdir -p .docker/data
mkdir -p .docker/data/crowdsec
mkdir -p .docker/data/letsencrypt
mkdir -p .docker/data/nextcloud
mkdir -p .docker/data/nextcloud-database
mkdir -p .docker/data/nextcloud-redis
mkdir -p .docker/data/vaultwarden
mkdir -p .docker/data/vaultwarden-database

mkdir -p .docker/logs
mkdir -p .docker/logs/nextcloud
mkdir -p .docker/logs/traefik
mkdir -p .docker/logs/vaultwarden

# fix to mount nextcloud.log
chown www-data:www-data ${LOG_PATH}/nextcloud

chmod +x scripts/nextcloud-post-installation.sh
chmod +x scripts/vaultwarden-entrypoint.sh

mkdir -p .docker/secrets

# Create secrets
generate_secret() {
  local secret_path="${SECRETS_PATH}/$1"
  if [ ! -f "$secret_path" ]; then
    openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > "$secret_path"
  fi
}

generate_secret "NEXTCLOUD_ADMIN_PASSWORD"
generate_secret "NEXTCLOUD_POSTGRES_PASSWORD"
generate_secret "NEXTCLOUD_REDIS_HOST_PASSWORD"
generate_secret "VAULTWARDEN_ADMIN_TOKEN"
generate_secret "VAULTWARDEN_POSTGRES_PASSWORD"

docker compose up -d
