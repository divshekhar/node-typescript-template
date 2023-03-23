SHELL := /bin/bash

.DEFAULT_GOAL := help

CONTAINER-NAME := node-typescript-container
IMAGE-NAME := node-typescript-template-image

.PHONY: help
help:
	@echo Usage: make [target] [target] ...
	@echo -
	@echo Targets: ["docker_build", "docker_run", "docker_clean", "docker_compose_up", "docker_compose_recreate", "docker_compose_down", "docker_compose_clean", "test", "fmt", "lint", "check"]
	@echo -
	@echo docker_build: Build the docker image.
	@echo docker_run: Run the docker image.
	@echo docker_container_remove: Remove the docker container.
	@echo docker_image_remove: Remove the docker image.
	@echo -
	@echo docker_compose_up: Run a local development environment with Docker Compose.
	@echo docker_compose_recreate: Recreate and run development docker compose.
	@echo docker_compose_down: Stop Docker Compose local development environment.
	@echo docker_compose_clean: Clean Docker Compose local development environment.
	@echo -
	@echo test: Run tests.
	@echo fmt: Format code.
	@echo lint: Run static analysis.
	@echo check: Run all checks for this project.

## Build the docker image
docker_build:
	@docker build -t $(IMAGE-NAME) .

## Run the docker image
docker_run:
	@docker run -it --rm --name $(CONTAINER-NAME) $(IMAGE-NAME)

## Stop the container
docker_stop:
	@docker stop $(CONTAINER-NAME)

## Remove the docker container
docker_container_remove:
	@docker container rm $(CONTAINER-NAME)

## Remove the docker image
docker_image_remove:
	@docker rmi $(IMAGE-NAME)

## Run a local development environment with Docker Compose.
docker_compose_up: 
	@docker-compose -f ./deployments/dev/docker-compose.yml up --build --force-recreate

## Recreate and run development docker compose
docker_compose_recreate: 
	@docker-compose -f ./deployments/dev/docker-compose.yml up --build --force-recreate

## Stop Docker Compose local development environment.
docker_compose_down: 
	@docker-compose -f ./deployments/dev/docker-compose.yml down

## Clean Docker Compose local development environment.
docker_compose_clean: 
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
