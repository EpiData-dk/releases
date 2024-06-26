#!/bin/bash

do_builds() {
    local project_dir="$1"
    local versions="$2"
    local basedir="$project_dir/darwin"

    source "$project_dir/lib/log.sh"
    source "$project_dir/lib/build.sh"

    info "Build DMG installer"
    do_loop_components "$basedir/build_dmg.sh" "$versions"
    info ""

    info "Build zip archive"
    do_loop_components "$basedir/build_zip.sh" "$versions"
    info ""
}