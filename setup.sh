#!/bin/bash
# General
LOGGER="./utils/print_log.sh"

bash "${LOGGER}" info "Execute environment setup"
su root ./install_webmin/install_webmin.sh 
su root ./install_docker/install_docker.sh 
su root ./install_docker_compose/install_docker_compose.sh 
bash "${LOGGER}" info "Environment setup complete"