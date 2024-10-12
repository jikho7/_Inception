echo "------------------------------- MARIADB START -------------------------------------"

# Initialisation de la base de données
# mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

mkdir -p /run/mysqld

# chown -R mysql:mysql /var/lib/mysql;
# chown -R mysql:mysql /run/mysqld;

chown -R 100:101 /var/lib/mysql  # launch mariadb container, do docker exec -it mariadb bash and got uid=100(mysql) gid=101(mysql) groups=101(mysql),101(mysql)
chown -R 100:101 /run/mysqld

mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

echo "Initialized the db..."

cat << EOF > /db_file
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqld --user=mysql --bootstrap < /db_file

exec /usr/bin/mysqld --user=mysql --console 