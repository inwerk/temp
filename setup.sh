docker compose down

# Import environment variables from .env file
# set -a && source .env && set +a

useradd --no-create-home nobody --shell /usr/sbin/nologin --uid 2000

mkdir -p /mnt/data
mkdir -p /mnt/data/letsencrypt
mkdir -p /mnt/data/nextcloud
mkdir -p /mnt/data/mysql
mkdir -p /mnt/data/secrets

openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_ROOT_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_REDIS_HOST_PASSWORD

docker compose up -d
