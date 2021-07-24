#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_lam /utils/print_log.sh)
LAM="LAM -"

# TODO: Install phpldapadmin
bash "${LOGGER}" info "${LAM} Re-index and fetch all available packages"
apt-get update -y

bash "${LOGGER}" info "${LAM} Download LAM in version 7.6.RC1-1_all"
wget http://prdownloads.sourceforge.net/lam/ldap-account-manager_7.6.RC1-1_all.deb

bash "${LOGGER}" info "${LAM} Install LAM in version 7.6.RC1-1_all"
apt install ./ldap-account-manager_7.6.RC1-1_all.deb -y

#bash "${LOGGER}" info "${LAM} Modify /etc/ldap-account-manager/config.cfg"
SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file www-data root 700 ./install_lam/resources/etc/ldap-account-manager/config.cfg /etc/ldap-account-manager/config.cfg)
echo ${SOURCE_COMMAND}
#rm /etc/ldap-account-manager/config.cfg
#cp ./install_lam/resources/etc/ldap-account-manager/config.cfg /etc/ldap-account-manager/
#chmod 700 /etc/ldap-account-manager/config.cfg
#chown www-data:root /etc/ldap-account-manager/config.cfg

#bash "${LOGGER}" info "${LAM} Modify /var/lib/ldap-account-manager/config/lam.conf"
SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file www-data root 600 ./install_lam/resources/var/lib/ldap-account-manager/config/lam.conf /var/lib/ldap-account-manager/config/lam.conf)
echo ${SOURCE_COMMAND}
#rm /var/lib/ldap-account-manager/config/lam.conf
#cp ./install_lam/resources/var/lib/ldap-account-manager/config/lam.conf /var/lib/ldap-account-manager/config/
#chmod 600 /var/lib/ldap-account-manager/config/lam.conf
#chown www-data:root /var/lib/ldap-account-manager/config/lam.conf