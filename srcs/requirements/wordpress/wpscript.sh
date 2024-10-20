#!/bin/sh

MAX_RETRIES=60
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
        /usr/sbin/php-fpm81 -F --fpm-config /etc/php81/php-fpm.conf 
    fi
}

main() {
    cd /var/www/html
    waitForMariaDB
    echo "MariaDB is ready, going to run"
    checkPHPFPM
}

main

# Keep the container running
sleep 9000000
