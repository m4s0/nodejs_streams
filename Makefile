.DEFAULT_GOAL:=help

.PHONY: build-containers
build-containers:
	docker-compose build

.PHONY: up
up:
	docker-compose up -d

.PHONY: up-prod
up-prod:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

.PHONY: down
down:
	docker-compose down

.PHONY: logs
logs:
	docker-compose logs -f

.PHONY: logs-node
logs-node:
	docker-compose logs -f node

.PHONY: bash
bash:
	docker-compose run node bash

.PHONY: install
install:
	docker-compose run --rm node bash -c 'npm install'

.PHONY: build
build:
	docker-compose run --rm node bash -c 'npm run build'

.PHONY: lint
lint:
	docker-compose run --rm node bash -c 'npm run lint'

.PHONY: run
run:
	docker-compose run --rm node bash -c 'npm run dev'

.PHONY: tests
tests:
	docker-compose run --rm node bash -c 'npm run tests'

.PHONY: unit
unit:
	docker-compose run --rm node bash -c 'npm run unit'

.PHONY: functional
functional:
	docker-compose run --rm node bash -c 'npm run functional'

