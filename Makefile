NAME = inception
PATH_DOCKER_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = ./srcs/.env

all : down build run

run:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} up

run-daemon:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} up -d

down:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} down

stop:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} stop

build:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} build

clean: down
	docker system prune -a

fclean: down
	docker system prune -a --volumes -f
#	prune supprime les objets non utiliser par docker, mettre $$ pour interpreter dans le contexte Makefile, -n == variable non vide
	volumes=$$(docker volume ls -q); \
	if [ -n "$$volumes" ]; then \
		docker volume rm -f $$volumes; \
	fi
# NOTE delete and create data content
	sudo rm -rf /home/jikho/data 
	mkdir -p /home/jikho/data/wordpress /home/jikho/data/mariadb
# 	sudo rm -rf ~/data 
#	mkdir -p ~/data/wordpress ~/data/mariadb

re: fclean all

.PHONY: all clean fclean re stop run run-daemon down build prepare prune-volumes