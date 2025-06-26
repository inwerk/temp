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

touch ${LOG_PATH}/nextcloud.log

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

docker compose up -d
