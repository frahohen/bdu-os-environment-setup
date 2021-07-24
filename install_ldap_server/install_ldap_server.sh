#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path /utils/print_log.sh)
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

#bash "${LOGGER}" info "${LDAP_SERVER} Replace /etc/nslcd.conf"
source ${FILE_UTILS} replace_file root nslcd 640 ./install_ldap_server/resources/etc/nslcd.conf /etc/nslcd.conf
#rm /etc/nslcd.conf
#cp ./install_ldap_server/resources/etc/nslcd.conf /etc/
#chmod 640 /etc/nslcd.conf
#chown root:nslcd /etc/nslcd.conf

#bash "${LOGGER}" info "${LDAP_SERVER} Replace /etc/nsswitch.conf"
source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/nsswitch.conf /etc/nsswitch.conf
#rm /etc/nsswitch.conf
#cp ./install_ldap_server/resources/etc/nsswitch.conf /etc/
#chmod 644 /etc/nsswitch.conf
#chown root:root /etc/nsswitch.conf

#bash "${LOGGER}" info "${LDAP_SERVER} Replace /etc/pam.d/common-auth"
source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/pam.d/common-auth /etc/pam.d/common-auth
#rm /etc/pam.d/common-auth
#cp ./install_ldap_server/resources/etc/pam.d/common-auth /etc/pam.d/
#chmod 644 /etc/pam.d/common-auth
#chown root:root /etc/pam.d/common-auth

#bash "${LOGGER}" info "${LDAP_SERVER} Replace /etc/pam.d/common-session"
source ${FILE_UTILS} replace_file root root 644 ./install_ldap_server/resources/etc/pam.d/common-session /etc/pam.d/common-session
#rm /etc/pam.d/common-session
#cp ./install_ldap_server/resources/etc/pam.d/common-session /etc/pam.d/
#chmod 644 /etc/pam.d/common-session
#chown root:root /etc/pam.d/common-session

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

# slapd installed => check if libpam-ldapd is installed

# libpam-ldapd not installed => remove package and reinstall slapd and libpam-ldapd

# libpam-ldapd installed => remove package and reinstall slapd and libpam-ldapd

# TODO: REQUIRED FILES FOR SETUP - START !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!:
# TODO: common-auth might be needed depending if the lam setup works without the 3 lines at the "Primary Block"
# TODO: common-session check if the session configuration can be changed with dpkg-reconfigure and if this change is needed to successfully execute LAM 
# TODO: put the sshd configuration file into the install_ssh_server installation and add it only if pam.d folder exists
# TODO: Copy nslcd.conf with enabled logfile location 
#    => Reinstall entire current setup and check systemctl status to ensure if nscd and nslcd is running or only nslcd
#    => Check if stopping with systemctl and starting both services is enough to ensure that these services are running on restart of system 
#    => or if the services also need to be started
# TODO: REQUIRED FILES FOR SETUP - END !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# systemctl stop nslcd
# systemctl stop nscd
# systemctl start nscd
# systemctl start nslcd

#bash "${LOGGER}" info "${LDAP_SERVER} Re-index and fetch all available packages"
#expect ./expect_slapd

#apt-get install libpam-ldapd -y

#"LDAP server URI:"
#ldap://127.0.0.1:389/

#"Distinguished name of the search base:"
#dc=ldap,dc=frahohen,dc=at

#"LDAP version to use:"
#3

#"Allow LDAP admin account to behave like local root?"
#yes

#"Does the LDAP database require login"
#no

#"LDAP administrative account:"
#cn=admin,dc=ldap,dc=frahohen,dc=at

#"LDAP administrative password:"
#admin

# this question should only appear if an existing pam.d configuration exists
#"Override local changes to /etc/pam.d/common-*?"
#yes





# export PATH=$PATH:/usr/sbin

# dpkg-reconfigure slapd

# TODO: DO THIS LATER OR IN SEPERATE BASH SCRIPT

# nano /etc/nslcd.conf
# nano /etc/pam.d/common-auth

# nano /etc/pam.d/common-session

# gpasswd -aG nslcd root


# Change nslcd to group root
# usermod -g root nslcd

# TODO: Install openLDAP (Lightweight Directory Access Protocol)
# TODO: Install libpam-ldapd (utilities will be installed) => PAM => Pluggable Authentication Modules
# TODO: Do configuration without manual input if possible
# TODO: Configure /etc/nslcd.conf
# TODO: Disable local password authentication (root will still have it) in /etc/pam.d/common-auth.conf
# TODO: Configure password-hash for authentication 
# TODO: Configure to create home directory with first login

# /pam.d/.. => look at nscd.conf for all files
# /etc/nscd.conf => -rw-r--r-- 1 root root 2387 Aug  1  2018 nscd.conf
# /etc/nslcd.conf => -rw-r----- 1 root nslcd 952 Jul  5 21:57 nslcd.conf

# service stop nslcd

# in /var/log/auth.log => authentication logging of PAMsu
