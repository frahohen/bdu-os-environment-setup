#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_ssh_server /utils/print_log.sh)
SSHSERVER="SSH Server -"

# change input windows to normal text line inputs
export DEBIAN_FRONTEND=readline

bash "${LOGGER}" info "${SSHSERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${SSHSERVER} Install SSH server"
# if files in /etc/pam.d/ are already modified execute expect
expect ./install_ssh_server/expect_openssh_server

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root root 644 ./install_ssh_server/resources/etc/ssh/ssh_config /etc/ssh/ssh_config)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root root 644 ./install_ssh_server/resources/etc/ssh/sshd_config /etc/ssh/sshd_config)
echo ${SOURCE_COMMAND}