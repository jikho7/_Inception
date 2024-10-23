#!/bin/sh

MAX_RETRIES=30
COUNTER=0

waitForMariaDB() {
    until echo 'SELECT 1' | mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" &> /dev/null || [ $COUNTER -eq $MAX_RETRIES ]; do
        COUNTER=$((COUNTER+1))
        echo "Waiting for MariaDB to be ready... (Attempt: $COUNTER)"
        sleep 1
    done

    if [ $COUNTER -eq $MAX_RETRIES ]; then
        echo "MariaDB not ready after $MAX_RETRIES attempts. Exiting."
        exit 1
    fi
}

checkPHPFPM() {
    if pgrep php-fpm > /dev/null; then
        echo "PHP-FPM is running"
    else
        echo "PHP-FPM is not running, starting PHP-FPM"
        /usr/sbin/php-fpm82 -F --fpm-config /etc/php82/php-fpm.conf
        # NOTE lance php-fpm82 avec le binaire
    fi
}

main() {
    cd /var/www/html
    waitForMariaDB
    echo "MariaDB is ready, going to run"
    # NOTE 4 core install
    wp core install --url=http://localhost:8080 --title=SiteTitle --admin_user=username --admin_password=mypassword --admin_email=my@email.com
    checkPHPFPM
}

main

# Keep the container running
sleep 9000000

# NOTE
# 1 wp core download [--path=<path>] [--locale=<locale>] [--version=<version>] [--skip-content] [--force] 	## NOTE - delete and create data content       ->                     Ou le mettre, sa version,  DANS DOCKERFILE
# 2 wp config create --dbname=<dbname> --dbuser=<dbuser> [--dbpass=<dbpass>]                                     ->                     WP-CONFIG.PHP FILE
# 3 wp db create                                                                                                 ->                     Dans dockerfile Mariadb
# 4 wp core install --url=wpclidemo.dev --title="WP-CLI" --admin_user=wpcli --admin_password=wpcli --admin_email=info@wp-cli.org  ->    	## NOTE - delete and create data contentWPSCIPT, rempli la database
# core = system de wordpress, qui sera mis dans data/wordpress

# En resume telecharger le systeme (core), faire config puis l'installer.