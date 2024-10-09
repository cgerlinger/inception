build:
	docker-compose -f srcs/docker-compose.yml build

up: build
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

re: down up

.PHONY: up down build re