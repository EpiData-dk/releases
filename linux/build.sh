#!/bin/bash

project_dir=$1
component=$2
version=$3
basedir="$(dirname ${0})"

# Prepare output dir
mkdir -p "${project_dir}/target/output/"

echo " - building debian installer (linux)"
${basedir}/build_deb.sh "${project_dir}" "${component}" "${version}"

echo " - building zip structures (linux)"
${basedir}/build_zip.sh "${project_dir}" "${component}" "${version}"
