# HELPER

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e "s/\[32m##/[33m/"
.PHONY: help

# DEFAULT

user      = root
container = php

##
## -- DOCKER --
##

up: ## docker-compose up -d --build --remove-orphans
	docker-compose up -d --build --remove-orphans
.PHONY: up

stop: ## docker-compose stop
	docker-compose stop
.PHONY: stop

restart: ## docker-compose restart
	docker-compose restart
.PHONY: restart

down: ## docker-compose down -v
	docker-compose down -v
.PHONY: down

reset: ## docker-compose down -v && docker-compose up -d --build --remove-orphans
	@$(MAKE) --no-print-directory down
	@$(MAKE) --no-print-directory start
.PHONY: reset

list: ## docker-compose ps -a
	docker-compose ps -a
.PHONY: list

perf: ## docker stats -a
	docker stats -a
.PHONY: perf

log: ## docker-compose logs -ft [container=php]
	docker-compose logs -ft $(container)
.PHONY: log

ssh: ## docker-compose exec -u [user=root] [container=php] /bin/sh -l
	docker-compose exec -u $(user) $(container) //bin//sh -c "cd /; exec /bin/sh -l"
.PHONY: ssh

cmd = php --version
exec: ## docker-compose exec -u [user=root] [container=php] [cmd="php --version"]
	docker-compose exec -u $(user) $(container) $(cmd)
.PHONY: exec
