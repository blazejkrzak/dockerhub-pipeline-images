#!/bin/bash

shopt -s extglob

{
  echo "---"
  echo "version: '3'"
  echo "services:"

  for FILE in */Dockerfile */*/Dockerfile */!(node_modules)/*/Dockerfile; do
    BASENAME=${FILE%/Dockerfile}
    if [[ "$FILE" == */!(node_modules)/*/Dockerfile ]]; then
      # $1/$2/$3 -> adorsys/$1:$3-$2
      IMAGE="adorsys/$(echo "${BASENAME}" | cut -d/ -f1):$(echo "${BASENAME}" | cut -d/ -f3)-$(echo "${BASENAME}" | cut -d/ -f2)"
    else
      # $1/$2 -> adorsys/$1:$2
      IMAGE="adorsys/${BASENAME/\//:}"
    fi
    echo "  ${BASENAME//[\/-]/_}:"
    echo "    image: ${IMAGE}"
    echo "    build:"
    echo "      context: ${BASENAME}"
  done

  echo ""
  echo "networks:"
  echo "  adorsys:"
  echo "    driver: bridge"
} > docker-compose.yml
