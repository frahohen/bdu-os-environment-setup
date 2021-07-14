#!/bin/bash
LOGGER="./utils/print_log.sh"
FILE_UTILS="File Utils -"

function replace_file {
    user="$1"
    group="$2"
    rights="$3"
    source_path="$4"
    destination_path="$5"

    bash "${LOGGER}" info "${FILE_UTILS} Replace $(destination_path)"

    rm $(destination_path)
    cp $(source_path) $(destination_path)
    chmod $(rights) $(destination_path)
    chown $(user):$(group) $(destination_path)
}