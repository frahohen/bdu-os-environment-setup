#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
# Repository
REPO_WEBMIN="deb https://download.webmin.com/download/repository sarge contrib"
FILE_SOURCE_LIST="/etc/apt/sources.list"

bash "${LOGGER}" info "Execute webmin installation"

if grep -Fxq "${REPO_WEBMIN}" "${FILE_SOURCE_LIST}"
then
	bash "${LOGGER}" info "Repository \"${REPO_WEBMIN}\" does already exist in file \"${FILE_SOURCE_LIST}\""
else
	bash "${LOGGER}" info "Add repository \"${REPO_WEBMIN}\" to file \"${FILE_SOURCE_LIST}\""
	echo "" >> "${FILE_SOURCE_LIST}"
	echo "#Webmin APT repository" >> "${FILE_SOURCE_LIST}"
	echo "${REPO_WEBMIN}" >> "${FILE_SOURCE_LIST}"
fi

bash "${LOGGER}" info "Installing GPG key"
apt-get install -y gnupg1
cd /root
wget https://download.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

bash "${LOGGER_UTIL}" info "Update and install webmin"
apt-get install -y apt-transport-https
apt-get clean all
apt-get update
apt-get upgrade
apt-get install -y webmin
