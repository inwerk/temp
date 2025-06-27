# Load environment variables
set -a
source .env
set +a

docker compose down

mkdir -p ${DATA_PATH}
mkdir -p ${DATA_PATH}/crowdsec
mkdir -p ${DATA_PATH}/letsencrypt
mkdir -p ${DATA_PATH}/nextcloud
mkdir -p ${DATA_PATH}/nextcloud-database
mkdir -p ${DATA_PATH}/nextcloud-redis
mkdir -p ${DATA_PATH}/secrets

# fix to mount nextcloud.log
mkdir -p ${DATA_PATH}/nextcloud/data
touch ${DATA_PATH}/nextcloud/data/nextcloud.log
chown www-data:www-data ${DATA_PATH}/nextcloud
chown www-data:www-data ${DATA_PATH}/nextcloud/data
chown www-data:www-data ${DATA_PATH}/nextcloud/data/nextcloud.log

chmod +x scripts/nextcloud-post-installation.sh
chmod +x scripts/vaultwarden-entrypoint.sh

# Create secrets
generate_secret() {
  local secret_path="${DATA_PATH}/secrets/$1"
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
