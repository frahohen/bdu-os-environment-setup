#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
LAM="LAM -"

# TODO: Install phpldapadmin
bash "${LOGGER}" info "${LAM} Re-index and fetch all available packages"
apt-get update -y

wget http://prdownloads.sourceforge.net/lam/ldap-account-manager_7.6.RC1-1_all.deb

apt install ./ldap-account-manager_7.6.RC1-1_all.deb -y