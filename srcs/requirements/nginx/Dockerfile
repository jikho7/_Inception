FROM alpine:3.19

# Mettre à jour et installer les paquets nécessaires
RUN apk update && apk upgrade && \
    apk add --no-cache \
    nginx \
    curl \
    openssl \
    mariadb-client \
    && mkdir -p /var/www/wordpress /var/run/php

    # Verifie si groupe et user www-data existe. si true, permet de continuer l execution
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

# Configuration des permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Creer repertoire pour ssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/cert.pem -keyout /etc/nginx/ssl/cert.key -subj "/C=SW/ST=VS/L=Lausane/O=42/OU=42/CN=jdefayes.42.ch/emailAddress=jdefayes@student.42lausanne.ch"
    # -x509 -> certificat auto-signé.
    # -nodes : Indique que la clé privée ne doit pas être chiffrée (pas de mot de passe).
    # -keyout : Le fichier de sortie pour la clé privée.
    # -out : Le fichier de sortie pour le certificat.
    # -subj : Définit les informations du certificat (modifie selon tes besoins)
# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=SW/ST=VS/L=Lausane/O=42/OU=42/CN=francois-xavier.42.ch/emailAddress=francois-xavier@student.42.fr"
# COPY /home/jikho/Documents/ssl_inception/cert.pem nginx:/etc/nginx/ssl/cert.pem
# COPY /home/jikho/Documents/ssl_inception/cert.key nginx:/etc/nginx/ssl/cert.key
# NOTE .pem .crt = meme chose, convention : .crt pour nginx // .key = cle privee

 # Copier la configuration de php-fpm et le script de démarrage
COPY conf/default.conf /etc/nginx/nginx.conf
COPY nginx.sh /nginx.sh
RUN chmod +x /nginx.sh

# Exposer le port pour PHP-FPM
EXPOSE 80

# Commande d'entrée
CMD ["sh", "/nginx.sh"]

# NOTE Certbot to obtain a free SSL certificate for Nginx.
