#! /bin/bash

cd /var/www/html

if [ ! -f "/usr/local/bin/wp" ]; then
	curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x /usr/local/bin/wp
fi

if [ ! -f "wp-load.php" ]; then
	echo "Downloading WordPress core files..."
	wp core download --allow-root
fi

if [ ! -f "wp-config.php" ]; then
	echo "Creating wp-config.php..."
	wp config create \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=${DB_HOST} \
		--allow-root
fi

if ! wp core is-installed --allow-root; then
	echo "Installing WordPress..."
	wp core install \
		--url=${DOMAIN_NAME} \
		--title=${TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL} \
		--allow-root
fi

if ! wp user list --field=user_login --allow-root | grep -q "^${USER}$"; then
	echo "Creating user ${USER}..."
	wp user create \
		${USER} \
		${USER_EMAIL} \
		--role=author \
		--user_pass=${USER_PASSWORD} \
		--allow-root
fi

if ! wp config get WP_CACHE --allow-root &>/dev/null; then
	wp config set WP_CACHE true --raw --allow-root
fi

chown -R www-data:www-data /var/www/html

php-fpm7.4 -F