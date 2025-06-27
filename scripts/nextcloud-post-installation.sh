# Add missing indices to the database.
occ db:add-missing-indices

# Perform mimetype migrations for Nextcloud.
occ maintenance:repair --include-expensive

# Set mode for background jobs to 'cron'.
occ background:cron

# Run background jobs between 01:00am UTC and 05:00am UTC.
occ config:system:set maintenance_window_start --type=integer --value=1

# Set default language to German.
occ config:system:set default_language --type=string --value='de'

# Set default locale to Germany.
occ config:system:set default_locale --type=string --value='de_DE'

# Set the default phone region to Germany.
occ config:system:set default_phone_region --type=string --value='DE'

# Set the default time zone to Europe/Berlin.
occ config:system:set default_timezone --type=string --value='Europe/Berlin'

# Disable default directory structure for new users.
occ config:system:set skeletondirectory --type=string --value=''

# Disable template directory for new users.
occ config:system:set templatedirectory --type=string --value=''

# Disable preview image generation
occ config:system:set enable_previews --type=boolean --value='false'

# Diasable user profiles
occ config:system:set profile.enabled --type=boolean --value='false'

# Disable profiles by default for new users
occ config:app:set settings profile_enabled_by_default --value='0'

# Disable system address book for all users
occ config:app:set dav system_addressbook_exposed --value='no'

# Update all Nextcloud apps.
occ app:update --all

# Download and install Nextcloud apps.
occ app:install calendar

# Disable redundant Nextcloud apps.
occ app:disable activity
occ app:disable comments
occ app:disable dashboard
occ app:disable files_reminders
occ app:disable firstrunwizard
occ app:disable nextcloud_announcements
occ app:disable notifications
occ app:disable photos
occ app:disable recommendations
occ app:disable support
occ app:disable survey_client
occ app:disable user_status
occ app:disable weather_status
