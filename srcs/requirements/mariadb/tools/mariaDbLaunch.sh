echo "------------------------------- MARIADB START -------------------------------------"

mkdir -p /run/mysqld

chown -R mysql:mysql /var/lib/mysql  # launch mariadb container, do docker exec -it mariadb bash and got uid=100(mysql) gid=101(mysql) groups=101(mysql),101(mysql)
chown -R mysql:mysql /run/mysqld

mysql_install_db --datadir=/var/lib/mysql --user=mysql # pour initialiser les fichiers de base de donnees Mysql, cree 

echo "Initialized the db..."

cat << EOF > /db_file
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

sleep 1
# mysqld = necessaire pour lancer le service mariadb = cuisto. & permet de lancer en arriere plan, a mettre a la fin de la commande
mysqld --user=mysql &

sleep 1
# execute ce qui est dans le script db_file, setting up de mariadb, creation des users, password etc.
mysql < /db_file

sleep 1
#supprimer mysqld sinon deux process en cours et ne fonctionne pas, killall + nom_du_process
killall mysqld

sleep 1
# lance le service en foreground, il est bloquant 
exec /usr/bin/mysqld --user=mysql --console 

# NOTE mysql serveur et mysqld, deamon, pour le service
# mysql = intermediaire entre client et la base de donnee
# container = batiment, infrastrucutre
# docker-compoes = quartier
# port = coup de telepone
# socket = au comptoir, dans le resto
