#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
DOCKER="Docker-Compose -"

bash "${LOGGER_UTIL}" info "${DOCKER} Install docker-compose"
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

bash "${LOGGER}" info "${DOCKER} Set executable permissions"
chmod +x /usr/local/bin/docker-compose