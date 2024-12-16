FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysqli \
	php7.4-curl \
	php7.4-gd \
	php7.4-intl \
	php7.4-mbstring \
	php7.4-imagick \
	php7.4-dom \
	php7.4-zip \
	curl \
	wget

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

COPY tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh"]
