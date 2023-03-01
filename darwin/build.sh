#!/bin/bash

project_dir=$1
component=$2
version=$3
basedir="$(dirname ${0})"

# Prepare output dir
mkdir -p "${project_dir}/target/output/"

echo " - building DMG image (darwin)"
${basedir}/build_dmg.sh "${project_dir}" "${component}" "${version}"

echo " - building zip structures (darwin)"
${basedir}/build_zip.sh "${project_dir}" "${component}" "${version}"
