# Add missing indices to the database.
docker exec -u www-data nextcloud /var/www/html/occ db:add-missing-indices

# Perform mimetype migrations for Nextcloud.
docker exec -u www-data nextcloud /var/www/html/occ maintenance:repair --include-expensive

# Set mode for background jobs to 'cron'.
docker exec -u www-data nextcloud /var/www/html/occ background:cron

# Add crontab to run background jobs every five minutes.
(crontab -l; echo "*/5  *  *  *  * docker exec -u www-data nextcloud php /var/www/html/cron.php")|awk '!x[$0]++'|crontab -

# Run background jobs between 01:00am UTC and 05:00am UTC.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set maintenance_window_start --type=integer --value=1

# Set default language to German.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set default_language --type=string --value='de'

# Set default locale to Germany.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set default_locale --type=string --value='de_DE'

# Set the default phone region to Germany.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set default_phone_region --type=string --value='DE'

# Set the default time zone to Europe/Berlin.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set default_timezone --type=string --value='Europe/Berlin'

# Disable default directory structure for new users.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set skeletondirectory --type=string --value=''

# Disable template directory for new users.
docker exec -u www-data nextcloud /var/www/html/occ config:system:set templatedirectory --type=string --value=''

# Disable preview image generation
docker exec -u www-data nextcloud /var/www/html/occ config:system:set enable_previews --type=boolean --value='false'

# Diasable user profiles
docker exec -u www-data nextcloud /var/www/html/occ config:system:set profile.enabled --type=boolean --value='false'

# Disable profiles by default for new users
docker exec -u www-data nextcloud /var/www/html/occ config:app:set settings profile_enabled_by_default --value='0'

# Disable system address book for all users
docker exec -u www-data nextcloud /var/www/html/occ config:app:set dav system_addressbook_exposed --value='no'

# Update all Nextcloud apps.
docker exec -u www-data nextcloud /var/www/html/occ app:update --all

# Download and install Nextcloud apps.
docker exec -u www-data nextcloud /var/www/html/occ app:install calendar

# Disable redundant Nextcloud apps.
docker exec -u www-data nextcloud /var/www/html/occ app:disable activity
docker exec -u www-data nextcloud /var/www/html/occ app:disable comments
docker exec -u www-data nextcloud /var/www/html/occ app:disable dashboard
docker exec -u www-data nextcloud /var/www/html/occ app:disable files_reminders
docker exec -u www-data nextcloud /var/www/html/occ app:disable firstrunwizard
docker exec -u www-data nextcloud /var/www/html/occ app:disable nextcloud_announcements
docker exec -u www-data nextcloud /var/www/html/occ app:disable notifications
docker exec -u www-data nextcloud /var/www/html/occ app:disable photos
docker exec -u www-data nextcloud /var/www/html/occ app:disable recommendations
docker exec -u www-data nextcloud /var/www/html/occ app:disable support
docker exec -u www-data nextcloud /var/www/html/occ app:disable survey_client
docker exec -u www-data nextcloud /var/www/html/occ app:disable user_status
docker exec -u www-data nextcloud /var/www/html/occ app:disable weather_status
