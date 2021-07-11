#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
SSHSERVER="SSH Server -"

# TODO: Install ssh server here
# TODO: Do required configuration for LDAP here
bash "${LOGGER}" info "${SSHSERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${SSHSERVER} Install SSH server"
apt-get install openssh-server -y