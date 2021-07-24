#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_webmin /utils/print_log.sh)
WEBMIN="Webmin -"

# Repository
REPO_WEBMIN="deb https://download.webmin.com/download/repository sarge contrib"
FILE_SOURCE_LIST="/etc/apt/sources.list"

if grep -Fxq "${REPO_WEBMIN}" "${FILE_SOURCE_LIST}"
then
	bash "${LOGGER}" info "${WEBMIN} Repository \"${REPO_WEBMIN}\" does already exist in file \"${FILE_SOURCE_LIST}\""
else
	bash "${LOGGER}" info "${WEBMIN} Add repository \"${REPO_WEBMIN}\" to file \"${FILE_SOURCE_LIST}\""
	echo "" >> "${FILE_SOURCE_LIST}"
	echo "#Webmin repository" >> "${FILE_SOURCE_LIST}"
	echo "${REPO_WEBMIN}" >> "${FILE_SOURCE_LIST}"
fi

bash "${LOGGER}" info "${WEBMIN} Install gnupg1"
apt-get install -y gnupg1

bash "${LOGGER}" info "${WEBMIN} Install GPG key"
cd /root
wget https://download.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

bash "${LOGGER}" info "${WEBMIN} Install apt-transport-https"
apt-get install -y apt-transport-https

bash "${LOGGER}" info "${WEBMIN} Clean all packages"
apt-get clean all
bash "${LOGGER}" info "${WEBMIN} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${WEBMIN} Upgrade all packages to the latest version available"
apt-get upgrade -y

bash "${LOGGER_UTIL}" info "${WEBMIN} Install webmin"
apt-get install -y webmin
