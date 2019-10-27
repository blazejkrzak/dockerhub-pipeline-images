#!/bin/bash

set -xeuo pipefail

# https://github.com/travis-ci/travis-build/blob/1317b0c9e96f5a56308138d869f0124de1b672b5/lib/travis/build/bash/travis_setup_env.bash
export ANSI_RED="\033[31;1m"
export ANSI_GREEN="\033[32;1m"
export ANSI_YELLOW="\033[33;1m"
export ANSI_RESET="\033[0m"
export ANSI_CLEAR="\033[0K"

# https://github.com/travis-ci/travis-build/blob/4f580b238530108cdd08719c326cd571d4e7b99f/lib/travis/build/bash/travis_retry.bash
travis_retry() {
  local result=0
  local count=1
  while [[ "${count}" -le 3 ]]; do
    [[ "${result}" -ne 0 ]] && {
      echo -e "\\n${ANSI_RED}The command \"${*}\" failed. Retrying, ${count} of 3.${ANSI_RESET}\\n" >&2
    }
    "${@}" && { result=0 && break; } || result="${?}"
    count="$((count + 1))"
    sleep 1
  done

  [[ "${count}" -gt 3 ]] && {
    echo -e "\\n${ANSI_RED}The command \"${*}\" failed 3 times.${ANSI_RESET}\\n" >&2
  }

  return "${result}"
}


echo "push to ${DOCKER_IMAGE}:${TAG}"
travis_retry docker push "${DOCKER_IMAGE}:${TAG}"

if [ -n "${ALIASES+x}" ]; then
  for ALIAS in ${ALIASES}; do
    echo "Pushing tag aliases ${ALIAS}"
    docker tag "${DOCKER_IMAGE}:${TAG}" "${DOCKER_IMAGE}:${ALIAS}"
    travis_retry docker push "${DOCKER_IMAGE}:${ALIAS}"
  done
fi

if [ -n "${SNAPSHOT+x}" ] && [ "$(date +%d)" -eq "1" ]; then
  echo "Pushing snapshot tag $(date +%Y%m)"
  docker tag "${DOCKER_IMAGE}:${TAG}" "${DOCKER_IMAGE}:$(date +%Y%m)"
  travis_retry docker push "${DOCKER_IMAGE}:$(date +%Y%m)"
fi
