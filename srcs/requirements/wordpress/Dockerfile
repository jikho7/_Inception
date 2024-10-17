# syntax=docker/dockerfile:1
FROM alpine:3.17

# Update and install the required packages for PHP 8
RUN apk update && apk upgrade && \
    apk add --no-cache \
<<<<<<< HEAD
    php8 \
    php8-fpm \
    php8-mysqli \
=======
    php \
    php-fpm \
    php-mysqli \
>>>>>>> 966089c (push jo juju)
    wget \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php

<<<<<<< HEAD
# Define the working directory
WORKDIR /var/www/wordpress
=======
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
>>>>>>> 966089c (push jo juju)

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

<<<<<<< HEAD
# Assign ownership to the www-data user
RUN chown -R www-data:www-data /var/www
=======
# # Assign ownership to the www-data user
# RUN chown -R www-data:www-data /var/www
>>>>>>> 966089c (push jo juju)

# Set permissions on directories and files
RUN chmod -R 755 /var/www

# Copy the WordPress configuration file
<<<<<<< HEAD
COPY tools/wp-config.php /var/www/wordpress/
=======
COPY conf/wp-config.php /var/www/html/
COPY wpscript.sh /wpscript.sh
RUN chmod +x /wpscript.sh
>>>>>>> 966089c (push jo juju)

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=mariadb:3306 \
    WORDPRESS_DB_USER=user \
    WORDPRESS_DB_PASSWORD=1234 \
    WORDPRESS_DB_NAME=wordpress

# Expose the port for PHP-FPM
EXPOSE 9000

# Command to start PHP-FPM
<<<<<<< HEAD
CMD ["php-fpm8", "-F"]
=======
CMD ["sh", "wpscript.sh"]

>>>>>>> 966089c (push jo juju)


