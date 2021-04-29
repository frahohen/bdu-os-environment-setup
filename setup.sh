#!/bin/bash
# General
LOGGER="./utils/print_log.sh"

bash "${LOGGER}" info "Enter root user password to execute webmin installation"
su root ./install_webmin/install_webmin.sh 