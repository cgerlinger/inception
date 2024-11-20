FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm7.4 php-mysql wget unzip

RUN mkdir -p /var/www/html

# Download and extract WordPress
RUN wget https://wordpress.org/latest.zip -P /tmp && \
	unzip /tmp/latest.zip -d /var/www/html && \
	rm /tmp/latest.zip

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html/wordpress

RUN mkdir -p /run/php

CMD ["php-fpm7.4", "-F"]
