FROM alpine:3.19
# virer les RUN (qui ajoute une couche a l image), mettre && \
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    php-phar \ 
    wget \
    php-mbstring \
    mariadb-client && \
    mkdir -p /var/www/wordpress /var/run/php /var/www/html && \
# NOTE besoin de php-phar pour utliser wp-cli qui est ensemble d'outils en ligne de commande pour gérer les installations WordPress
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
# NOTE 1 core download
    cd /var/www/html/ && /usr/local/bin/wp core download && \
# Verifie si groupe et user www-data existe. si true, permet de continuer l execution
    addgroup -S www-data || true && adduser -S -G www-data www-data || true && \
# CREATION FICHIER info.php, test si php est actif
    echo "<?php phpinfo();?>" > /var/www/html/info.php
# Copy the WordPress et Php configuration file et modifie permissions pour fichier www.conf
COPY conf/wp-config.php /var/www/html/
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
#RUN chown www-data:www-data /etc/php82/php-fpm.d/www.conf && \
#RUN chmod 644 /etc/php82/php-fpm.d/www.conf
COPY tools/wpscript.sh /wpscript.sh
RUN chmod +x /wpscript.sh && \
# Assign ownership to the www-data user
    chown -R www-data:www-data /var/www/html /etc/php82/php-fpm.d/www.conf && \
# Set permissions on directories
    chmod -R 755 /var/www/html && \
# Set permissions on files
    chmod 644 /etc/php82/php-fpm.d/www.conf
# Expose the port for PHP-FPM
EXPOSE 9000
# TODO EXPOSE 9000

# Command to start PHP-FPM
CMD ["sh", "/wpscript.sh"]



