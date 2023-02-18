MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# include makefiles
export SELF ?= $(MAKE)
PROJECT_PATH ?= $(shell 'pwd')
include $(PROJECT_PATH)/Makefile.*

#-------------------------------------------------------------------------------
# docker
#-------------------------------------------------------------------------------

DOCKER_IMAGE ?= hansohn/terraform
DOCKER_TAG ?= latest
ENTRYPOINT ?= bash

DOCKER_RUN_ARGS ?=
DOCKER_RUN_ARGS += --interactive
DOCKER_RUN_ARGS += --tty
DOCKER_RUN_ARGS += --rm
DOCKER_RUN_ARGS += --workdir /app
DOCKER_RUN_ARGS += --volume ${PWD}:/app
DOCKER_RUN_ARGS += --volume ${HOME}/.aws:/root/.aws
DOCKER_RUN_ARGS += --volume ${HOME}/.gitconfig:/root/.gitconfig
DOCKER_RUN_ARGS += --volume ${HOME}/.netrc:/root/.netrc
DOCKER_RUN_ARGS += --pull always

## Docker run image
docker/run:
	-@if docker stats --no-stream > /dev/null 2>&1; then \
		echo "[INFO] Running '$(DOCKER_IMAGE)/$(DOCKER_TAG)' docker image"; \
		docker run $(DOCKER_RUN_ARGS) "$(DOCKER_IMAGE):$(DOCKER_TAG)" "$(ENTRYPOINT)"; \
	else \
		echo "[ERROR] Docker 'run' failed. Docker daemon is not Running."; \
	fi
.PHONY: docker/run

## Docker lint, build and run image
docker: docker/run
.PHONY: docker

#-------------------------------------------------------------------------------
# clean
#-------------------------------------------------------------------------------

## Clean docker build images
clean/docker:
	-@if docker stats --no-stream > /dev/null 2>&1; then \
		if docker inspect --type=image "$(DOCKER_IMAGE):$(DOCKER_TAG)" > /dev/null 2>&1; then \
			echo "[INFO] Removing docker image '$(DOCKER_IMAGE)/$(DOCKER_TAG)'"; \
			docker rmi -f $$(docker inspect --format='{{ .Id }}' --type=image $(DOCKER_IMAGE):$(DOCKER_TAG)); \
		fi; \
	fi
.PHONY: clean/docker

TG_GENERATED_FILES += .terraform .terraform.lock.hcl .terragrunt-cache
## Clean terraform generated files/directories
clean/terraform:
	-@for i in $(TG_GENERATED_FILES); do \
		find . -name "$$i" -prune -exec rm -rf {} \;; \
	done
.PHONY: clean/terraform

## Clean everything
clean: clean/docker clean/terraform
.PHONY: clean
