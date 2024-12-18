all: up

up: build
	@mkdir -p /home/cgerling/data
	@docker compose -f srcs/docker-compose.yml up -d

build: validate-env
	@docker compose -f srcs/docker-compose.yml build

down:
	@docker compose -f srcs/docker-compose.yml down

validate-env:
	@chmod +x srcs/validate_env.sh
	@./srcs/validate_env.sh

reset: down
	@docker volume rm -f srcs_mariadb srcs_wordpress
	@rm -rf /home/cgerling/data

re: down up

status:
	@docker ps -a
	@docker volume ls
	@docker network ls

.PHONY: all up down build re reset validate-env status

