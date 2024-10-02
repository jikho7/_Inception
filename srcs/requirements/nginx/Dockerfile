FROM alpine:latest

# Mettre à jour et installer Nginx, OpenSSL dans une seule commande pour réduire les couches
RUN apk update && apk upgrade && \
    apk add nginx openssl && \
    mkdir -p /etc/nginx/ssl /var/run/nginx /var/log/nginx && \
    chown -R nginx:nginx /var/run/nginx /var/log/nginx
    # openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    # -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

COPY conf/default.conf /etc/nginx/nginx.conf
# COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY tool/start_ngx.sh /usr/local/start_ngx.sh
# RUN chmod +x /usr/local/start_ngx.sh

# Exposer le port 80 pour Nginx
EXPOSE 80

# Commande pour démarrer Nginx en mode foreground
CMD ["nginx", "-g", "daemon off;"]