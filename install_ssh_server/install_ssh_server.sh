#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
SSHSERVER="SSH Server -"

bash "${LOGGER}" info "${SSHSERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${SSHSERVER} Install SSH server"
apt-get install openssh-server -y

bash "${LOGGER}" info "${SSHSERVER} Modify /etc/ssh/ssh_config"
rm /etc/ssh/ssh_config
cp ./install_ldap_server/resources/etc/ssh/ssh_config /etc/ssh/
chmod 644 /etc/ssh/ssh_config
chown root:root /etc/ssh/ssh_config

bash "${LOGGER}" info "${SSHSERVER} Modify /etc/ssh/sshd_config"
rm /etc/ssh/sshd_config
cp ./install_ldap_server/resources/etc/ssh/sshd_config /etc/ssh/
chmod 644 /etc/ssh/sshd_config
chown root:root /etc/ssh/sshd_config