#!/bin/bash
# General
LOGGER="./utils/print_log.sh"

bash "${LOGGER}" info "Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "Install apt-transport-https, ca-certificates, curl, gnupg and lsb-release"
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

bash "${LOGGER}" info "Install GPG key"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Repository (lsb_release and the GPG key is at this point installed)
REPO_DOCKER="deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
FILE_SOURCE_LIST="/etc/apt/sources.list.d/docker.list"

bash "${LOGGER}" info "Add repository \"${REPO_DOCKER}\" to file \"${FILE_SOURCE_LIST}\""
echo "" >> "${FILE_SOURCE_LIST}"
echo "#Docker repository" >> "${FILE_SOURCE_LIST}"
echo "${REPO_DOCKER}" | tee "${FILE_SOURCE_LIST}" > /dev/null

bash "${LOGGER}" info "Re-index and fetch all available packages"
apt-get update -y

bash "${LOGGER_UTIL}" info "Install docker"
apt-get install -y docker-ce docker-ce-cli containerd.io