NAME = inception
PATH_DOCKER_COMPOSE = ./srcs/docker-compose.yml
# PATH_TO_ENV_FILE = /Users/francois-xavier/Desktop/.private_env
PATH_TO_ENV_FILE = ./srcs/.env

RESET_COLOR = \033[0m

all : prepare down build run

run:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} up

run-daemon:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} up -d

down:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} down

stop:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} stop

prepare:
	# if [ ! -d srcs/.env ]; then \
	# 	cp ${PATH_TO_ENV_FILE} srcs/.env; \
	# fi
	if [ ! -d ${PATH_V_WORDPRESS} ]; then \
		mkdir -p ${PATH_V_WORDPRESS}; \
	fi
	if [ ! -d ${PATH_V_MARIADB} ]; then \
		mkdir -p ${PATH_V_MARIADB}; \
	fi

build:
	docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} build

clean: down
	docker system prune -a

fclean: down
	docker system prune -a --volumes -f
	volumes=$$(docker volume ls -q); \
	if [ -n "$$volumes" ]; then \
		docker volume rm -f $$volumes; \
	fi
# NOTE delete and create data content
	sudo rm -rf ./srcs/data 
	mkdir -p ./srcs/data/wordpress ./srcs/data/mariadb

re: fclean all

delete-volumes :
    # Assigner les IDs de tous les conteneurs à la variable 'containers' # Vérifier si 'containers' n'est pas vide
    containers=$(docker ps -a -q); \
    if [ -n "$$containers" ]; then \
        docker rm -f $$containers; \
    fi
    # Assigner les IDs de tous les volumes à la variable 'volumes'  # Vérifier si 'volumes' n'est pas vide
    volumes=$(docker volume ls -q); \
    if [ -n "$$volumes" ]; then \
        docker volume rm $$volumes; \
    fi

status :

	@echo "\033[44mRunning Containers :${RESET_COLOR}"
	@docker compose -f ${PATH_DOCKER_COMPOSE} -p ${NAME} ps
	@echo ""

	@echo "\033[44mImages :${RESET_COLOR}"
	@docker images
	@echo ""

	@echo "\033[44mContainers :${RESET_COLOR}"
	@docker container ls -a
	@echo ""

	@echo "\033[44mVolumes :${RESET_COLOR}"
	@docker volume ls
	@echo ""

	@echo "\033[44mNetwork :${RESET_COLOR}"
	@docker network ls
	@echo ""


.PHONY: all clean fclean re status stop run run-daemon down build prepare delete-volumes prune-volumes