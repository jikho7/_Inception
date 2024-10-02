echo "------------------------------- MARIADB START -------------------------------------"

# Initialisation de la base de données
# mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

mkdir -p /run/mysqld

chown -R mysql:mysql /var/lib/mysql;
chown -R mysql:mysql /run/mysqld;

# Lancement de mariadb en arrière plan
# mysqld --user=mysql --datadir=/var/lib/mysql &

# pid=$!

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

# mariadb-client -u mysql -e "ALTER USER 'mysql'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mariadb-client -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# mariadb-client -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mariadb-client -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mariadb-client -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Affichage des bases de données actuelles et des utilisateurs
# echo "------------------"
# mysqld -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"
# echo "------------------"
# mysqld -u mysql -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT User FROM mysql.user;"
# echo "------------------"

# Remplacement du processus shell par mysqld
exec /usr/bin/mysqld --user=mysql --console 

#-datadir=/var/lib/mysql