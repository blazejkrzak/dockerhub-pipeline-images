#!/bin/bash

set -euo pipefail

## Setup assertion
DEVNULL=/dev/null
DOCKER_CONTAINER=$(docker run --rm -d "${DOCKER_IMAGE}:${TAG}")
sleep 2


# Test that docker has initialized redis-server
docker exec -it "${DOCKER_CONTAINER}" ps |grep "redis-server" > "${DEVNULL}"


# Shut down the container
docker stop "${DOCKER_CONTAINER}" > "${DEVNULL}"