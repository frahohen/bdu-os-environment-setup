#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
# Repository
REPO_WEBMIN="deb https://download.webmin.com/download/repository sarge contrib"
FILE_SOURCE_LIST="/etc/apt/sources.list"

if grep -Fxq "${REPO_WEBMIN}" "${FILE_SOURCE_LIST}"
then
	bash "${LOGGER}" info "Repository \"${REPO_WEBMIN}\" does already exist in file \"${FILE_SOURCE_LIST}\""
else
	bash "${LOGGER}" info "Add repository \"${REPO_WEBMIN}\" to file \"${FILE_SOURCE_LIST}\""
	echo "" >> "${FILE_SOURCE_LIST}"
	echo "#Webmin APT repository" >> "${FILE_SOURCE_LIST}"
	echo "${REPO_WEBMIN}" >> "${FILE_SOURCE_LIST}"
fi

bash "${LOGGER}" info "Install gnupg1"
apt-get install -y gnupg1

bash "${LOGGER}" info "Install GPG key"
cd /root
wget https://download.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

bash "${LOGGER}" info "Install apt-transport-https"
apt-get install -y apt-transport-https

bash "${LOGGER}" info "Clean all packages"
apt-get clean all
bash "${LOGGER}" info "Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "Upgrade all packages to the latest version available"
apt-get upgrade -y

bash "${LOGGER_UTIL}" info "Install webmin"
apt-get install -y webmin
