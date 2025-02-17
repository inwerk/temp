docker compose down

# Import environment variables from .env file
# set -a && source .env && set +a

mkdir -p /mnt/data
mkdir -p /mnt/data/letsencrypt
mkdir -p /mnt/data/nextcloud && chown 2000:2000 /mnt/data/nextcloud
mkdir -p /mnt/data/mysql && chown 2000:2000 /mnt/data/mysql
mkdir -p /mnt/data/secrets

# workaround for https://github.com/nextcloud/docker/issues/1494 and https://github.com/nextcloud/docker/issues/763
mkdir -p /mnt/data/.fix
touch /mnt/data/.fix/remoteip.conf && chown 2000:2000 /mnt/data/.fix/remoteip.conf
touch /mnt/data/.fix/redis-session.ini && chown 2000:2000 /mnt/data/.fix/redis-session.ini

openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_ROOT_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_REDIS_HOST_PASSWORD
"test" > /mnt/data/secrets/NEXTCLOUD_REDIS_HOST_PASSWORD

docker compose up -d
