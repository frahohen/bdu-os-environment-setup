#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_ldap_server /utils/print_log.sh)
LDAP_SERVER="LDAP Server -"

# change input windows to normal text line inputs
export DEBIAN_FRONTEND=readline
# allow execution of dpkg
export PATH=$PATH:/usr/sbin

bash "${LOGGER}" info "${LDAP_SERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${LDAP_SERVER} Install expect scripting language"
apt-get install expect -y

bash "${LOGGER}" info "${LDAP_SERVER} Install slapd"
# libpam-ldapd not installed => do fresh installation
expect ./install_ldap_server/expect_slapd_install

bash "${LOGGER}" info "${LDAP_SERVER} Install libpam-ldapd"
expect ./install_ldap_server/expect_libpam_ldapd_install

bash "${LOGGER}" info "${LDAP_SERVER} Reconfigure slapd properly"
expect ./install_ldap_server/expect_slapd_reconfigure

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nslcd 640 ./install_ldap_server/resources/etc/nslcd.conf /etc/nslcd.conf)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/nsswitch.conf /etc/nsswitch.conf)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/pam.d/common-auth /etc/pam.d/common-auth)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/pam.d/common-session /etc/pam.d/common-session)
echo ${SOURCE_COMMAND}

bash "${LOGGER}" info "${LDAP_SERVER} Restart services nslcd and nscd"
systemctl stop nslcd
systemctl stop nscd
systemctl start nscd
systemctl start nslcd

#bash "${LOGGER}" info "${LDAP_SERVER} Configure admin password for admin(root) user"
#ldapmodify -H ldapi:// -Y EXTERNAL -f ./install_ldap_server/admin_dit_passwd.ldif
#ldapmodify -H ldap:// -x -D "cn=admin,dc=ldap,dc=frahohen,dc=at" -W -f ./install_ldap_server/admin_regular_dit_passwd.ldif
# TODO: use dpkg-reconfigure slapd to configure LDAP properly

# libpam-ldapd is installed => remove package and reinstall slapd and libpam-ldapd
#apt-get remove --auto-remove libpam-ldapd
#apt-get remove --auto-remove slapd


