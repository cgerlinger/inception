FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/nginx.key -out /etc/nginx/nginx.crt \
	-subj "/CN=localhost"

COPY tools/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]