# Add missing indices to the database.
docker exec nextcloud /var/www/html/occ db:add-missing-indices

# Perform mimetype migrations for Nextcloud.
docker exec nextcloud /var/www/html/occ maintenance:repair --include-expensive

# Set mode for background jobs to 'cron'.
docker exec nextcloud /var/www/html/occ background:cron

# Add crontab to run background jobs every five minutes.
(crontab -l; echo "*/5  *  *  *  * php /var/www/html/cron.php") | docker exec nextcloud crontab -

# Run background jobs between 01:00am UTC and 05:00am UTC.
docker exec nextcloud /var/www/html/occ config:system:set maintenance_window_start --type=integer --value=1

# Set default language to German.
docker exec nextcloud /var/www/html/occ config:system:set default_language --type=string --value='de'

# Set default locale to Germany.
docker exec nextcloud /var/www/html/occ config:system:set default_locale --type=string --value='de_DE'

# Set the default phone region to Germany.
docker exec nextcloud /var/www/html/occ config:system:set default_phone_region --type=string --value='DE'

# Set the default time zone to Europe/Berlin.
docker exec nextcloud /var/www/html/occ config:system:set default_timezone --type=string --value='Europe/Berlin'

# Disable default directory structure for new users.
docker exec nextcloud /var/www/html/occ config:system:set skeletondirectory --type=string --value=''

# Disable template directory for new users.
docker exec nextcloud /var/www/html/occ config:system:set templatedirectory --type=string --value=''

# Update all Nextcloud apps.
docker exec nextcloud /var/www/html/occ app:update --all

# Disable redundant Nextcloud apps.
docker exec nextcloud /var/www/html/occ app:disable activity
docker exec nextcloud /var/www/html/occ app:disable dashboard
docker exec nextcloud /var/www/html/occ app:disable firstrunwizard
docker exec nextcloud /var/www/html/occ app:disable nextcloud_announcements
docker exec nextcloud /var/www/html/occ app:disable notifications
docker exec nextcloud /var/www/html/occ app:disable suspicious_login
docker exec nextcloud /var/www/html/occ app:disable twofactor_totp
docker exec nextcloud /var/www/html/occ app:disable user_ldap
