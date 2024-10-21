echo "------------------------------- MARIADB START -------------------------------------"

# Initialiser la base de données si elle n'existe pas
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
    echo "Initialized the db..."
fi

echo "initi database done"

sleep 5

echo "Running /db_file" >> /var/log/mysql/db_creation.log
cat << EOF > /db_file
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER IF EXISTS 'root'@'localhost' IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}";
CREATE DATABASE IF NOT EXISTS "${MYSQL_DATABASE}";
CREATE USER IF NOT EXISTS "${MYSQL_USER}"@"%" IDENTIFIED BY "${MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON "${MYSQL_DATABASE}".* TO "${MYSQL_USER}"@"%";
FLUSH PRIVILEGES;
EOF

mysqld --user=mysql --bootstrap < /db_file

echo "Starting MariaDB..."
# Démarrer MariaDB
exec /usr/bin/mysqld --user=mysql --console --log-error=/var/log/mysql/error.log
echo "Mariadb started"