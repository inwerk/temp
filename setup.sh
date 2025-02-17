docker compose down

# Import environment variables from .env file
# set -a && source .env && set +a

mkdir -p /mnt/data
mkdir -p /mnt/data/letsencrypt
mkdir -p /mnt/data/nextcloud
mkdir -p /mnt/data/mysql
mkdir -p /mnt/data/secrets

touch /mnt/data/.conf/remoteip.conf && chown 33:33 /mnt/data/.conf/remoteip.conf
touch /mnt/data/.conf/redis-session.ini && chown 33:33 /mnt/.conf/data/redis-session.ini

openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_ROOT_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_MYSQL_PASSWORD
openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 > /mnt/data/secrets/NEXTCLOUD_REDIS_HOST_PASSWORD

docker compose up -d
