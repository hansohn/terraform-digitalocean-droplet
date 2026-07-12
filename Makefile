MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := dev
.DELETE_ON_ERROR:
.SUFFIXES:

# include makefiles
export SELF ?= $(MAKE)
PROJECT_PATH ?= $(shell 'pwd')
include $(PROJECT_PATH)/Makefile.*

# main
export UNAME_S ?= $(shell uname -s)

export DIGITALOCEAN_TOKEN ?=
export REPO_NAME := $(shell basename ${PWD})

DOCKER_IMAGE ?= hansohn/terraform-digitalocean
DOCKER_TAG   ?= latest
DOCKER_PULL  ?= always

DOCKER_ARGS ?=
DOCKER_ARGS += --interactive
DOCKER_ARGS += --tty
DOCKER_ARGS += --rm
DOCKER_ARGS += --env DIGITALOCEAN_TOKEN
DOCKER_ARGS += --env REPO_NAME
DOCKER_ARGS += --workdir /app
DOCKER_ARGS += --volume ${PWD}:/app
DOCKER_ARGS += --volume ${HOME}/.ssh/known_hosts:/root/.ssh/known_hosts
DOCKER_ARGS += --volume ${HOME}/.gitconfig:/root/.gitconfig:ro
DOCKER_ARGS += --pull $(DOCKER_PULL)

SSH_AUTH_SOCK_MAGIC_PATH := /run/host-services/ssh-auth.sock
ifeq ($(UNAME_S),Darwin)
DOCKER_ARGS += --env SSH_AUTH_SOCK=$(SSH_AUTH_SOCK_MAGIC_PATH)
DOCKER_ARGS += --volume $(SSH_AUTH_SOCK_MAGIC_PATH):$(SSH_AUTH_SOCK_MAGIC_PATH)
endif


## Run local dev env
dev: ENTRYPOINT ?= bash

dev:
	docker run \
		$(DOCKER_ARGS) \
		$(DOCKER_IMAGE):$(DOCKER_TAG) \
		$(ENTRYPOINT)

.PHONY: dev

CLEAN_DIRS  += .terraform
CLEAN_FILES += .terraform.lock.hcl terraform.plan
$(CLEAN_DIRS):
	find . -type d -name $@ -prune -exec rm -rf {} \;
$(CLEAN_FILES):
	find . -type f -name $@ -exec rm -f {} \;

## Clean everything
clean: $(CLEAN_DIRS) $(CLEAN_FILES)
.PHONY: clean $(CLEAN_DIRS) $(CLEAN_FILES)
