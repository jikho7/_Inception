# syntax=docker/dockerfile:1
FROM alpine:3.17

# Update and install the required packages for PHP 8
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    wget \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Download and extract WordPress
RUN mkdir -p /var/www/html
RUN cd /var/www/html/ && wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

# Verifie si groupe et user www-data existe. si true, permet de continuer l execution
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

# CREATION FICHIER info.php
RUN echo "<?php phpinfo();?>" > /var/www/html/info.php

# Assign ownership to the www-data user
RUN chown -R www-data:www-data /var/www/html
# Set permissions on directories and files
RUN chmod -R 755 /var/www/html

# Copy the WordPress et Php configuration file et modifie permissions pour fichier wordpress_pool.conf 
COPY conf/wp-config.php /var/www/html/
COPY conf/wordpress_pool.conf /etc/php81/php-fpm.d/wordpress_pool.conf
RUN chown www-data:www-data /etc/php81/php-fpm.d/wordpress_pool.conf && \
    chmod 644 /etc/php81/php-fpm.d/wordpress_pool.conf
COPY wpscript.sh /wpscript.sh
RUN chmod +x /wpscript.sh

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=mariadb:3306 \
    WORDPRESS_DB_USER=user \
    WORDPRESS_DB_PASSWORD=1234 \
    WORDPRESS_DB_NAME=wordpress

# Expose the port for PHP-FPM
EXPOSE 9001

# Command to start PHP-FPM
CMD ["sh", "/wpscript.sh"]



