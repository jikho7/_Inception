FROM alpine:3.14

# Mettre à jour et installer les paquets nécessaires
RUN apk update && apk upgrade && \
    apk add --no-cache \
    nginx \
    # php \
    # php-fpm \
    # php-mysqli \
    # wget \
    mariadb-client \
    && mkdir -p /var/www/wordpress /var/run/php

# Configuration des permissions
#RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# # Copier la configuration de php-fpm et le script de démarrage
# COPY conf/www.conf /etc/php/php-fpm.d/www.conf
COPY conf/default.conf /etc/nginx/nginx.conf
# COPY tool/start_wdp.sh /usr/local/start_wdp.sh
# RUN chmod +x /usr/local/start_wdp.sh

# Exposer le port pour PHP-FPM
EXPOSE 80

# Commande d'entrée
CMD ["nginx", "-g", "daemon off;"]
