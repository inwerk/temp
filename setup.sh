docker compose down

# Import environment variables from .env file
# set -a && source .env && set +a

mkdir -p /mnt/data
mkdir -p /mnt/data/letsencrypt
mkdir -p /mnt/data/nextcloud
mkdir -p /mnt/data/mysql

docker compose up -d
