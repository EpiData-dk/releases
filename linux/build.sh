#!/bin/bash

project_dir=$1
component=$2
version=$3
basedir="$(dirname ${0})"

echo " - building debian installer"
${basedir}/build_deb.sh "${project_dir}" "${component}" "${version}"

echo " - building zip structures"
${basedir}/build_zip.sh "${project_dir}" "${component}" "${version}"
