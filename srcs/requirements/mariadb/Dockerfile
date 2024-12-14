FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server gettext-base

COPY tools/init.sql /etc/mysql/init.sql
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir /run/mysqld

COPY tools/startup.sh startup.sh
RUN chmod +x startup.sh

CMD [ "./startup.sh" ]
