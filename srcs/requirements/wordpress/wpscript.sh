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
    fi
}

main() {
    cd /var/www/html
    waitForMariaDB
    echo "going to run "
}

main

sleep 9000000