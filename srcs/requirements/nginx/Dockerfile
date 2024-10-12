FROM alpine:3.14

# Mettre à jour et installer les paquets nécessaires
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8.0 \
    php8.0-fpm \
    php8.0-mysqli \
    wget \
    mariadb-client \
    && mkdir -p /var/www/wordpress /var/run/php

# Configuration des permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Copier la configuration de php-fpm et le script de démarrage
COPY conf/www.conf /etc/php8/php-fpm.d/www.conf
COPY tool/start_wdp.sh /usr/local/start_wdp.sh
RUN chmod +x /usr/local/start_wdp.sh

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Commande d'entrée
ENTRYPOINT ["sh", "/usr/local/start_wdp.sh"]
