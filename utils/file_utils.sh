#!/bin/bash

# retrieves the absolute path of the script path from the root directory provided
# example:
#   example root directory:                                                                                             ./test_project/
#   file utils path must be for this example:                                                                           ./test_project/utils/file_utils.sh
#   example absolute path calculated from file_utils.sh:                                                                /home/dev/test_project/
#   example absolute path calculated if path parameter "some_folder/some_script.sh" provided for get_absolute_path():   /home/dev/test_project/some_folder/some_script.sh
function get_absolute_path() {
    local RELATIVE_SCRIPT_PATH_FROM_ROOT_DIRECTORY=$1
    local FILE_UTILS_PATH=$(dirname $(realpath "$0"))
    printf "${FILE_UTILS_PATH//utils}${RELATIVE_SCRIPT_PATH_FROM_ROOT_DIRECTORY}\n"
}

LOGGER=$(get_absolute_path utils/print_log.sh)
FILE_UTILS="File Utils -"

function replace_file() {
    local USER=$1
    local GROUP=$2
    local RIGHTS=$3
    local SOURCE_PATH=$4
    local DESTINATION_PATH=$5

    bash "${LOGGER}" info "${FILE_UTILS} Replace ${destination_path}"

    rm ${DESTINATION_PATH}
    cp ${SOURCE_PATH} ${DESTINATION_PATH}
    chmod ${RIGHTS} ${DESTINATION_PATH}
    chown ${USER}:${GROUP) ${DESTINATION_PATH}
}

# --- add functions here ---

case $1 in 
    get_absolute_path) "$@"; exit;; 
    replace_file) "$@"; exit;;
esac