all: up

up: build
	@mkdir -p /home/cgerling/data/mariadb
	@mkdir -p /home/cgerling/data/wordpress
	@docker compose -f srcs/docker-compose.yml up -d

build: validate-env
	@docker compose -f srcs/docker-compose.yml build

down:
	@docker compose -f srcs/docker-compose.yml down

validate-env:
	@chmod +x srcs/validate_env.sh
	@./srcs/validate_env.sh

reset: down
	@docker volume rm -f mariadb wordpress
	@sudo chown -R cgerling:cgerling /home/cgerling/data
	@rm -rf /home/cgerling/data

re: down up

status:
	@docker ps -a
	@docker volume ls

.PHONY: all up down build re reset validate-env status

