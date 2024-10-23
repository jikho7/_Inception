FROM alpine:3.19

# Mise à jour et installation de MariaDB
RUN apk update && apk add mariadb mariadb-client 

# Copier le script de démarrage dans le conteneur
# alpine prend le dosser etc/my.cnf.d/mariadb-server.cnf pour les configs, different de debian
COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf 
COPY tools/mariaDbLaunch.sh /usr/local/mariaDbLaunch.sh

# Donner les permissions d'exécution au script
RUN chmod +x /usr/local/mariaDbLaunch.sh

# Expose le port de MariaDB
EXPOSE 3306

# Démarre le service MariaDB en utilisant le script de démarrage
CMD ["sh", "/usr/local/mariaDbLaunch.sh"]