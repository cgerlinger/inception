build:
	docker-compose -f srcs/docker-compose.yml build

up: build
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

# clean: down
# 	docker system prune -af
# 	docker volume rm $$(docker volume ls -q)

re: down up

.PHONY: up down build re clean
