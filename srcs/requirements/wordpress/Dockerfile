FROM alpine:3.19

RUN apk update && apk upgrade && \
    apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    php-phar \ 
    wget \
    php-mbstring \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php
# NOTE besoin de php-phar pour utliser wp-cli qui est ensemble d'outils en ligne de commande pour gérer les installations WordPress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# NOTE 1 core download
RUN mkdir -p /var/www/html
RUN cd /var/www/html/ && /usr/local/bin/wp core download

# Verifie si groupe et user www-data existe. si true, permet de continuer l execution
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

# CREATION FICHIER info.php
RUN echo "<?php phpinfo();?>" > /var/www/html/info.php

# Assign ownership to the www-data user
RUN chown -R www-data:www-data /var/www/html
# Set permissions on directories and files
RUN chmod -R 755 /var/www/html

# Copy the WordPress et Php configuration file et modifie permissions pour fichier wordpress_pool.conf
# COPY conf/php.ini /etc/php82/
COPY conf/wp-config.php /var/www/html/
COPY conf/wordpress_pool.conf /etc/php82/php-fpm.d/wordpress_pool.conf
RUN chown www-data:www-data /etc/php82/php-fpm.d/wordpress_pool.conf && \
    chmod 644 /etc/php82/php-fpm.d/wordpress_pool.conf
COPY tools/wpscript.sh /wpscript.sh
RUN chmod +x /wpscript.sh
# RUN mkdir -p /var/www/html/wp-content/uploads && \
#     chown -R www-data:www-data /var/www/html/wp-content/uploads && \
#     chmod -R 755 /var/www/html/wp-content/uploads && \
#     chmod g+s /var/www/html/wp-content/uploads
# RUN chown www-data:www-data /tmp
# RUN chmod 755 /tmp

# RUN mv /var/www/html/wp-content/plugins /var/www/html/wp-content/plugins_disabled

# Expose the port for PHP-FPM
EXPOSE 9001

# Command to start PHP-FPM
CMD ["sh", "/wpscript.sh"]



