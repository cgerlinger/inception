FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y php-fpm php-mysql wget unzip

# Create the directory for WordPress
RUN mkdir -p /var/www/html

# Download and extract WordPress
RUN wget https://wordpress.org/latest.zip -P /tmp && \
	unzip /tmp/latest.zip -d /var/www/html && \
	rm /tmp/latest.zip

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html/wordpress

# Create a PHP-FPM socket directory
RUN mkdir -p /run/php

CMD ["php-fpm7.4", "-F"]
