service mysql start
echo "CREATE DATABASE wpdb;" | mysql -u root
echo "CREATE USER 'napo'@'localhost' identified by '1234';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'napo'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
