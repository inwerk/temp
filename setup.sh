docker compose down

# Import environment variables from .env file
# set -a && source .env && set +a

docker secret create NEXTCLOUD_MYSQL_ROOT_PASSWORD <(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9)
docker secret create NEXTCLOUD_MYSQL_PASSWORD <(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9)
docker secret create NEXTCLOUD_REDIS_HOST_PASSWORD <(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9)

mkdir -p /mnt/data
mkdir -p /mnt/data/letsencrypt
mkdir -p /mnt/data/nextcloud
mkdir -p /mnt/data/mysql

docker compose up -d
