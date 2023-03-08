#!/bin/bash

components=("analysis" "entryclient" "manager")

do_loop_components() {
    local script="$1"
    local versions="$2"

    local len=${#components[@]}
    for (( i=0; i<$len; i++ ))
    do
        local component="${components[$i]}"
        local version=$(jq .[$i].version <<< $versions)

        echo " - ${component^}: ${version}"
        "$script" "${project_dir}" "${component}" "${version}"
    done
}

