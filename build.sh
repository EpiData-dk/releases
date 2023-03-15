#!/bin/bash

source "lib/log.sh"

if [ "$#" -ne 1 ]; then
    error "Incorrect number of parameters!"
    error "Specify either linux, darwin or windows:"
    fatal "./build_all.sh [linux|darwin|windows]"
fi

project_dir=${PWD}
os=$1; shift;

if [ ! -d "$os" ] && [ ! -f "$os/requirements.sh" ]; then
    fatal "No such OS supported: $os"
fi

verify_commands() {
  local msgs=()
  for cmd; do
    command -v "$cmd" >/dev/null || msgs+=("command \"$cmd\" not found")
  done
  [[ ${#msgs[@]} -eq 0 ]] || fatal "These commands were not found. Please install them:"$'\n' "${msgs[@]/%/$'\n'}"
  debug "Validated commands: $*"
}

# Needed commands
source "$os/requirements.sh"

cmds=(xq jq)

mapfile -t scmds < <(os_commands)
cmds+=("${scmds[@]}")

verify_commands "${cmds[@]}" 

# Setup for each os builds
# - Prepare output dir
mkdir -p "${project_dir}/target/output/"

# - Program versions
versions=$(xq . pom.xml | jq ".project.dependencies.dependency")

# - Do the builds
source "${os}/build.sh"
do_builds "${project_dir}" "${versions}"