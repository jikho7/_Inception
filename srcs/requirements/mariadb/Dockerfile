FROM alpine

# Mise à jour et installation de MariaDB
RUN apk update && apk add mariadb mariadb-client

# Copier le script de démarrage dans le conteneur
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariaDbLaunch.sh /usr/local/mariaDbLaunch.sh

# Donner les permissions d'exécution au script
RUN chmod +x /usr/local/mariaDbLaunch.sh

# Expose le port de MariaDB
EXPOSE 3306

# Démarre le service MariaDB en utilisant le script de démarrage
CMD ["sh", "/usr/local/mariaDbLaunch.sh"]