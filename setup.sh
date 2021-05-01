#!/bin/bash
# General
LOGGER="./utils/print_log.sh"

bash "${LOGGER}" info "Execute environment setup"
su root ./install_webmin/install_webmin.sh 
bash "${LOGGER}" info "Environment setup complete"