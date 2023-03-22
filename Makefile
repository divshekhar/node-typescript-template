SHELL := /bin/bash

.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo Usage: make [target] [target] ...
	@echo -
	@echo Targets: ["up", "recreate", "down", "clean", "test", "fmt", "lint", "check"]
	@echo -
	@echo up: Run a local development environment with Docker Compose.
	@echo recreate: Recreate and run development docker compose.
	@echo down: Stop Docker Compose local development environment.
	@echo clean: Clean Docker Compose local development environment.
	@echo test: Run tests.
	@echo fmt: Format code.
	@echo lint: Run static analysis.
	@echo check: Run all checks for this project.

## Run a local development environment with Docker Compose.
up: 
	@docker-compose -f ./deployments/dev/docker-compose.yml up --build --force-recreate

## Recreate and run development docker compose
recreate: 
	@docker-compose -f ./deployments/dev/docker-compose.yml up --build --force-recreate

## Stop Docker Compose local development environment.
down: 
	@docker-compose -f ./deployments/dev/docker-compose.yml down

## Clean Docker Compose local development environment.
clean: 
	@docker-compose -f ./deployments/dev/docker-compose.yml down --remove-orphans --volumes

.PHONY: test
## Run tests
test: 
	@npm test

## Format code
fmt: 
	@npm run format

## Run static analysis
lint: 
	@npm run lint

## Run all checks for this project
check: 
	@npm run format:check
	@npm run lint
	@npm run test
	@npm run build
