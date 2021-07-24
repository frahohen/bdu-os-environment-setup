#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_firewall /utils/print_log.sh)
WEBMIN="Firewall -"

# TODO: check if ufw is needed => if not needed only apply firewall configuration here to ensure only the required ports are ALLOWED
# TODO: install ufw firewall if not installed
# TODO: disable by default every port
# TODO: set for every application allow and maybe port
