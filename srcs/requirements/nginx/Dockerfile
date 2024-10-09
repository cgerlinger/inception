FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

COPY conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]