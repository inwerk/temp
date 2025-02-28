# Load environment variables
export $(grep -v '^#' .env | xargs)

docker compose down

mkdir -p ${VOLUME_PATH}
mkdir -p ${VOLUME_PATH}/letsencrypt
mkdir -p ${VOLUME_PATH}/nextcloud && chown 2022:2022 ${VOLUME_PATH}/nextcloud
mkdir -p ${VOLUME_PATH}/nextcloud-mysql && chown 2022:2022 ${VOLUME_PATH}/nextcloud-mysql
mkdir -p ${VOLUME_PATH}/secrets

# Workaround for https://github.com/nextcloud/docker/issues/1494 and https://github.com/nextcloud/docker/issues/763
mkdir -p ${VOLUME_PATH}/.fix
touch ${VOLUME_PATH}/.fix/remoteip.conf && chown 2022:2022 ${VOLUME_PATH}/.fix/remoteip.conf
touch ${VOLUME_PATH}/.fix/redis-session.ini && chown 2022:2022 ${VOLUME_PATH}/.fix/redis-session.ini

# Create secrets
generate_secret() {
  local secret_path="${VOLUME_PATH}/secrets/$1"
  if [ ! -f "$secret_path" ]; then
    openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > "$secret_path"
  fi
}

generate_secret "NEXTCLOUD_ADMIN_PASSWORD"
generate_secret "NEXTCLOUD_MYSQL_ROOT_PASSWORD"
generate_secret "NEXTCLOUD_MYSQL_PASSWORD"
generate_secret "NEXTCLOUD_REDIS_HOST_PASSWORD"

docker compose up -d
