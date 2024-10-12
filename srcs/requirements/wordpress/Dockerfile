# syntax=docker/dockerfile:1
FROM alpine:3.17

# Update and install the required packages for PHP 8
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    wget \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php

# Define the working directory
WORKDIR /var/www/wordpress

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

# Assign ownership to the www-data user
RUN chown -R www-data:www-data /var/www

# Set permissions on directories and files
RUN chmod -R 755 /var/www

# Copy the WordPress configuration file
COPY tools/wp-config.php /var/www/wordpress/

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=mariadb:3306 \
    WORDPRESS_DB_USER=user \
    WORDPRESS_DB_PASSWORD=1234 \
    WORDPRESS_DB_NAME=wordpress

# Expose the port for PHP-FPM
EXPOSE 9000

# Command to start PHP-FPM
CMD ["php-fpm8", "-F"]


