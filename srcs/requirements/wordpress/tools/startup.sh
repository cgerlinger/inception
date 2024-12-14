#! /bin/bash

while ! mysql -h${DB_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1;" >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 5
done

cd /var/www/html
curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp

wp core download --allow-root
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${DB_HOST} --allow-root
wp core install --url=${DOMAIN_NAME} --title=${TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} --allow-root
wp user create ${USER} ${USER_EMAIL} --role=author --user_pass=${USER_PASSWORD} --allow-root

wp config set WP_CACHE true --raw --allow-root

chown -R www-data:www-data /var/www/html

php-fpm7.4 -F