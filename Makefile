validate-env:
	@chmod +x srcs/validate_env.sh
	@./srcs/validate_env.sh

build: validate-env
	@docker-compose -f srcs/docker-compose.yml build

up: build
	@docker-compose -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f srcs/docker-compose.yml down

reset: down
	@docker volume rm -f srcs_mariadb srcs_wordpress

re: down up

status:
	@docker ps -a
	@docker volume ls
	@docker network ls

.PHONY: up down build re reset validate-env status

