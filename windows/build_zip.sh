#!/bin/bash

project_dir="$1"
component="$2"
version="$3"

ssl_version="1.0.2u"

component_dir="${project_dir}/${component}"
build_dir="$(mktemp -d)"
output_dir="${project_dir}/target/output"
tmpdir=$(mktemp -d)

epidata_component="epidata${component}"

# copy binary
mkdir -p "${build_dir}/"
cp "${project_dir}/target/${component}/binaries/x86_64-win64/"* "${build_dir}/"

# copy documentation
mkdir -p "${build_dir}/docs/"
cp "${project_dir}/target/${component}/docs/"* "${build_dir}/docs/"
cp "${project_dir}/target/docs/"* "${build_dir}/docs/"

# copy samples
mkdir -p "${build_dir}/samples/"
cp "${project_dir}/target/samples/"* "${build_dir}/samples/"

# Get ssl library
mkdir -p "${tmpdir}"
wget -q "https://indy.fulgan.com/SSL/openssl-${ssl_version}-x64_86-win64.zip" -O "${tmpdir}/openssl.zip"
unzip -q "${tmpdir}/openssl.zip" "*.dll" -d "${build_dir}"

pushd "${build_dir}/" > /dev/null 2>&1
zip -9 -r "${output_dir}/${epidata_component}.${version}.win64.zip" . > /dev/null 2>&1
popd > /dev/null 2>&1

# clean up
rm -fr "${build_dir}/" "${tmpdir}/"
