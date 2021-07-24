#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path /utils/print_log.sh)
SSHSERVER="SSH Server -"

# change input windows to normal text line inputs
export DEBIAN_FRONTEND=readline

bash "${LOGGER}" info "${SSHSERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${SSHSERVER} Install SSH server"
# if files in /etc/pam.d/ are already modified execute expect
expect ./install_ssh_server/expect_openssh_server

#bash "${LOGGER}" info "${SSHSERVER} Modify /etc/ssh/ssh_config"
source ${FILE_UTILS} replace_file root root 644 ./install_ssh_server/resources/etc/ssh/ssh_config /etc/ssh/ssh_config
#rm /etc/ssh/ssh_config
#cp ./install_ssh_server/resources/etc/ssh/ssh_config /etc/ssh/
#chmod 644 /etc/ssh/ssh_config
#chown root:root /etc/ssh/ssh_config

#bash "${LOGGER}" info "${SSHSERVER} Modify /etc/ssh/sshd_config"
#source $(FILE_UTILS)
source ${FILE_UTILS} replace_file root root 644 ./install_ssh_server/resources/etc/ssh/sshd_config /etc/ssh/sshd_config
#rm /etc/ssh/sshd_config
#cp ./install_ssh_server/resources/etc/ssh/sshd_config /etc/ssh/
#chmod 644 /etc/ssh/sshd_config
#chown root:root /etc/ssh/sshd_config