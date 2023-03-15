#!/bin/bash

do_builds() {
    local project_dir="$1"
    local versions="$2"
    local basedir="$project_dir/linux"

    source "$project_dir/lib/log.sh"
    source "$project_dir/lib/build.sh"

    info "Build debian installer:"
    do_loop_components "$basedir/build_deb.sh" "$versions"
    info ""

    info "Build tar archive:"
    do_loop_components "$basedir/build_tar.sh" "$versions"
    info ""
}