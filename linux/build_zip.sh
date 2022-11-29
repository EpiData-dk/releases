#!/bin/bash

projectdir="$1"
component="$2"
version="$3"

component_dir="${projectdir}/${component}"
basedir="$(dirname ${0})"
build_dir="${projectdir}/target/build"

epidata_component="epidata${component}"

# copy binary
mkdir -p "${build_dir}/"
cp "${projectdir}/target/${component}/binaries/x86_64-linux/"* "${build_dir}/"

# copy documentation
mkdir -p "${build_dir}/docs/"
cp "${projectdir}/target/${component}/docs/"* "${build_dir}/docs/"
cp "${projectdir}/target/docs/"* "${build_dir}/docs/"

# copy samples
mkdir -p "${build_dir}/samples/"
cp "${projectdir}/target/samples/"* "${build_dir}/samples/"

tar -zcv -C "${build_dir}" -f "${projectdir}/target/${epidata_component}.${version}.linux.tgz" . > /dev/null 2>&1

# clean up
rm -fr "${build_dir}"
