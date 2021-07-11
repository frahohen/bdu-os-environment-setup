#!/bin/bash
# General
LOGGER="./utils/print_log.sh"
LDAP_SERVER="LDAP Server -"

# change input windows to normal text line inputs
export DEBIAN_FRONTEND=readline
# allow execution of dpkg
export PATH=$PATH:/usr/sbin

bash "${LOGGER}" info "${LDAP_SERVER} Re-index and fetch all available packages"
apt-get update -y
bash "${LOGGER}" info "${LDAP_SERVER} Install expect scripting language"
apt-get install expect -y

bash "${LOGGER}" info "${LDAP_SERVER} Check if slapd and libpam-ldapd are installed"
SLAPD_INSTALLED=$(dpkg -l | grep slapd)
LIBPAM_LDAPD_INSTALLED=$(dpkg -l | grep libpam-ldapd)

if [ -z "$(SLAPD_INSTALLED)"]
then 
    # slapd not installed => check if libpam-ldapd is installed
    if [ -z "$(LIBPAM_LDAPD_INSTALLED)"]
    then
        bash "${LOGGER}" info "${LDAP_SERVER} Install slapd and libpam-ldapd"
        # libpam-ldapd not installed => do fresh installation
        ./install_ldap_server/expect_slapd_install
        ./install_ldap_server/expect_libpam_ldapd_install
    else
        bash "${LOGGER}" info "${LDAP_SERVER} Install slapd and libpam-ldapd"
        # libpam-ldapd is installed => remove package and reinstall slapd and libpam-ldapd
        #apt-get remove --auto-remove libpam-ldapd
        #apt-get remove --auto-remove slapd
    fi
else
    # slapd installed => check if libpam-ldapd is installed
    if [ -z "$(LIBPAM_LDAPD_INSTALLED)"]
    then
        bash "${LOGGER}" info "${LDAP_SERVER} Install slapd and libpam-ldapd"
        # libpam-ldapd not installed => remove package and reinstall slapd and libpam-ldapd
    else
        bash "${LOGGER}" info "${LDAP_SERVER} Install slapd and libpam-ldapd"
        # libpam-ldapd installed => remove package and reinstall slapd and libpam-ldapd
    fi
fi

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
