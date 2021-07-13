#!/bin/bash
# General
LOGGER="./utils/print_log.sh"

bash "${LOGGER}" info "Execute environment setup"
# install user/group LDAP server and LAM as management interface
su root ./install_ldap_server/install_ldap_server.sh
su root ./install_lam/install_lam.sh
# install ssh server and configure for LDAP
su root ./install_ssh_server/install_ssh_server.sh
# install WEBMIN management interface
su root ./install_webmin/install_webmin.sh
# install docker with docker-compose 
su root ./install_docker/install_docker.sh 
su root ./install_docker_compose/install_docker_compose.sh 
# install and configure firewall after all packages are installed and setup
#su root ./install_firewall/install_firewall.sh
bash "${LOGGER}" info "Environment setup complete"