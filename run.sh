# Load environment variables
set -a
source .env
set +a

chmod +x scripts/nextcloud-post-installation.sh
chmod +x scripts/vaultwarden-entrypoint.sh

mkdir -p .docker
mkdir -p .docker/secrets

# Create secrets
generate_secret() {
  local secret_path=".docker/secrets/$1"
  if [ ! -f "$secret_path" ]; then
    openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > "$secret_path"
  fi
}

generate_secret "NEXTCLOUD_ADMIN_PASSWORD"
generate_secret "NEXTCLOUD_POSTGRES_PASSWORD"
generate_secret "NEXTCLOUD_REDIS_HOST_PASSWORD"
generate_secret "VAULTWARDEN_ADMIN_TOKEN"
generate_secret "VAULTWARDEN_POSTGRES_PASSWORD"

# Workaround for https://github.com/nextcloud/docker/issues/1494
touch .docker/remoteip.conf && chown 1000:1000 .docker/remoteip.conf

# Workaround for https://github.com/nextcloud/docker/issues/763
touch .docker/redis-session.ini && chown 1000:1000 .docker/redis-session.ini

docker compose up -d
