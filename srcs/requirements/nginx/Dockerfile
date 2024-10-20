FROM alpine:3.14

# Mettre à jour et installer les paquets nécessaires
RUN apk update && apk upgrade && \
    apk add --no-cache \
    nginx \
    curl \
    mariadb-client \
    && mkdir -p /var/www/wordpress /var/run/php

# Verifie si groupe et user www-data existe. si true, permet de continuer l execution
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

# Configuration des permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# # Copier la configuration de php-fpm et le script de démarrage
COPY conf/default.conf /etc/nginx/nginx.conf
COPY nginx.sh /nginx.sh
RUN chmod +x /nginx.sh

# Exposer le port pour PHP-FPM
EXPOSE 80

# Commande d'entrée
CMD ["sh", "/nginx.sh"]
