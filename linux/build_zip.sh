#!/bin/bash

project_dir="$1"
component="$2"
version="$3"

component_dir="${project_dir}/${component}"
basedir="$(dirname ${0})"
build_dir="${project_dir}/target/build"
output_dir="${project_dir}/target/output"

epidata_component="epidata${component}"

# copy binary
mkdir -p "${build_dir}/"
cp "${project_dir}/target/${component}/binaries/x86_64-linux/"* "${build_dir}/"

# copy documentation
mkdir -p "${build_dir}/docs/"
cp "${project_dir}/target/${component}/docs/"* "${build_dir}/docs/"
cp "${project_dir}/target/docs/"* "${build_dir}/docs/"

# copy samples
mkdir -p "${build_dir}/samples/"
cp "${project_dir}/target/samples/"* "${build_dir}/samples/"

tar -zcv -C "${build_dir}" -f "${output_dir}/${epidata_component}.${version}.linux.tgz" . > /dev/null 2>&1

# clean up
rm -fr "${build_dir}"
