FROM alpine:3.14

# Mise à jour et installation de MariaDB
RUN apk update && apk add mariadb mariadb-client

# Création des répertoires de travail et des logs
RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql

# Copier le fichier de configuration et le script de démarrage dans le conteneur
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariaDbLaunch.sh /usr/local/mariaDbLaunch.sh

# Donner les permissions d'exécution au script
RUN chmod +x /usr/local/mariaDbLaunch.sh

# Changer le propriétaire des répertoires
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql 
# mysql:mysql,  launch mariadb container, do docker exec -it mariadb sh \ id and got uid=100(mysql) gid=101(mysql) groups=101(mysql),101(mysql)

# Changer permissions des repertoires
RUN chmod -R 755 /var/lib/mysql /run/mysqld /var/log/mysql

# pour executer la prochaine commande en tant qu utilisateur mysql
# USER mysql

# Exposer le port de MariaDB
EXPOSE 3306

# Démarrer le service MariaDB en utilisant le script de démarrage
CMD ["sh", "/usr/local/mariaDbLaunch.sh"]