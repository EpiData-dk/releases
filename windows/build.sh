#!/bin/bash

do_builds() {
    local project_dir="$1"
    local versions="$2"
    local basedir="$project_dir/windows"

    source "$project_dir/lib/log.sh"
    source "$project_dir/lib/build.sh"

    info "Build All-in-one installer:"
    "$basedir/build_msi.sh" "$project_dir" "$versions"
    info ""

    info "Build zip archive:"
    do_loop_components "$basedir/build_zip.sh" "$versions"
    info ""
}