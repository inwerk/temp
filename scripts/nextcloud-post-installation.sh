# Add missing indices to the database.
/var/www/html/occ db:add-missing-indices

# Perform mimetype migrations for Nextcloud.
/var/www/html/occ maintenance:repair --include-expensive

# Set mode for background jobs to 'cron'.
/var/www/html/occ background:cron

# Run background jobs between 01:00am UTC and 05:00am UTC.
/var/www/html/occ config:system:set maintenance_window_start --type=integer --value=1

# Set default language to German.
/var/www/html/occ config:system:set default_language --type=string --value='de'

# Set default locale to Germany.
/var/www/html/occ config:system:set default_locale --type=string --value='de_DE'

# Set the default phone region to Germany.
/var/www/html/occ config:system:set default_phone_region --type=string --value='DE'

# Set the default time zone to Europe/Berlin.
/var/www/html/occ config:system:set default_timezone --type=string --value='Europe/Berlin'

# Disable default directory structure for new users.
/var/www/html/occ config:system:set skeletondirectory --type=string --value=''

# Disable template directory for new users.
/var/www/html/occ config:system:set templatedirectory --type=string --value=''

# Disable preview image generation
/var/www/html/occ config:system:set enable_previews --type=boolean --value='false'

# Diasable user profiles
/var/www/html/occ config:system:set profile.enabled --type=boolean --value='false'

# Disable profiles by default for new users
/var/www/html/occ config:app:set settings profile_enabled_by_default --value='0'

# Disable system address book for all users
/var/www/html/occ config:app:set dav system_addressbook_exposed --value='no'

# Update all Nextcloud apps.
/var/www/html/occ app:update --all

# Download and install Nextcloud apps.
/var/www/html/occ app:install calendar
/var/www/html/occ app:install contacts

# Disable redundant Nextcloud apps.
/var/www/html/occ app:disable activity
/var/www/html/occ app:disable comments
/var/www/html/occ app:disable dashboard
/var/www/html/occ app:disable files_reminders
/var/www/html/occ app:disable firstrunwizard
/var/www/html/occ app:disable nextcloud_announcements
/var/www/html/occ app:disable notifications
/var/www/html/occ app:disable photos
/var/www/html/occ app:disable recommendations
/var/www/html/occ app:disable support
/var/www/html/occ app:disable survey_client
/var/www/html/occ app:disable user_status
/var/www/html/occ app:disable weather_status
