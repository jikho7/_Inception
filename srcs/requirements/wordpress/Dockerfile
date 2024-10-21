# syntax=docker/dockerfile:1
FROM alpine:3.14

# Update and install the required packages for PHP 8
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    wget \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 -C /var/www/wordpress && \
    rm latest.tar.gz

# Verify if group and user www-data exist. If true, allow execution to continue
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true
RUN addgroup -S wordpress_user || true && adduser -S wordpress_user -G wordpress_user || true

# Create the wp-content directory if it doesn't exist
RUN mkdir -p /var/www/html/wp-content

# Set ownership and permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 775 /var/www/html/wp-content

# Create the debug.log file and set permissions
RUN touch /var/www/html/wp-content/debug.log && \
    chown www-data:www-data /var/www/html/wp-content/debug.log && \
    chmod 664 /var/www/html/wp-content/debug.log

# Copy the WordPress and PHP configuration files and modify permissions for wordpress_pool.conf 
COPY conf/wp-config.php /var/www/html/
COPY conf/wordpress_pool.conf /etc/php81/php-fpm.d/wordpress_pool.conf
RUN chown www-data:www-data /etc/php81/php-fpm.d/wordpress_pool.conf && \
    chmod 644 /etc/php81/php-fpm.d/wordpress_pool.conf

# Copy the script and make it executable
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


# # syntax=docker/dockerfile:1
# FROM alpine:3.17

# # Update and install the required packages for PHP 8
# RUN apk update && apk upgrade && \
#     apk add --no-cache \
#     php \
#     php-fpm \
#     php-mysqli \
#     wget \
#     mariadb-client && \
#     mkdir -p /var/www/wordpress /var/run/php

# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/local/bin/wp

# # Download and extract WordPress
# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz --strip-components=1 && \
#     rm latest.tar.gz

# # Verifie si groupe et user www-data existe. si true, permet de continuer l execution
# RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true
# RUN addgroup -S wordpress_user || true && adduser -S wordpress_user -G wordpress_user || true


# # CREATION FICHIER info.php
# RUN mkdir -p /var/www/html && \
#     echo "<?php phpinfo();?>" > /var/www/html/info.php

# # Create the wp-content directory if it doesn't exist
# RUN mkdir -p /var/www/html/wp-content

# # Set ownership and permissions
# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html \
#     && chmod -R 775 /var/www/html/wp-content

# # Create the debug.log file
# RUN touch /var/www/html/wp-content/debug.log

# # Copy the WordPress et Php configuration file et modifie permissions pour fichier wordpress_pool.conf 
# COPY conf/wp-config.php /var/www/html/
# COPY conf/wordpress_pool.conf /etc/php81/php-fpm.d/wordpress_pool.conf
# RUN chown www-data:www-data /etc/php81/php-fpm.d/wordpress_pool.conf && \
#     chmod 644 /etc/php81/php-fpm.d/wordpress_pool.conf
# COPY wpscript.sh /wpscript.sh
# RUN chmod +x /wpscript.sh

# # Set environment variables for WordPress
# ENV WORDPRESS_DB_HOST=mariadb \
#     WORDPRESS_DB_USER=user \
#     WORDPRESS_DB_PASSWORD=1234 \
#     WORDPRESS_DB_NAME=wordpress

# # Expose the port for PHP-FPM
# EXPOSE 9001

# # Command to start PHP-FPM
# CMD ["sh", "/wpscript.sh"]



