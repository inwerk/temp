# Load environment variables
set -a
source .env
set +a

# Paths for persistent volumes
export DATA_PATH=".docker/data"
export SECRETS_PATH=".docker/secrets"
export LOG_PATH=".docker/logs"

mkdir -p .docker

mkdir -p ${DATA_PATH}
mkdir -p ${DATA_PATH}/crowdsec
mkdir -p ${DATA_PATH}/letsencrypt
mkdir -p ${DATA_PATH}/nextcloud
mkdir -p ${DATA_PATH}/nextcloud-database
mkdir -p ${DATA_PATH}/nextcloud-redis
mkdir -p ${DATA_PATH}/secrets

mkdir -p ${LOG_PATH}
mkdir -p ${LOG_PATH}/nextcloud

# fix to mount nextcloud.log
chown www-data:www-data ${LOG_PATH}/nextcloud

chmod +x scripts/nextcloud-post-installation.sh
chmod +x scripts/vaultwarden-entrypoint.sh

mkdir -p ${SECRETS_PATH}

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
