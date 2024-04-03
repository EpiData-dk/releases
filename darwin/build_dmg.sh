#!/bin/bash

project_dir="$1"
component="$2"
component_name="${component^}"
version="$3"

component_dir="${project_dir}/${component}"
basedir="$(dirname ${0})"
build_dir=$(mktemp -d)
output_dir="${project_dir}/target/output"

epidata_component="epidata${component}"

# copy structure
mkdir -p "${build_dir}"
cp -r "${basedir}/EpiData.app" "${build_dir}"

# copy binary
mkdir -p "${build_dir}/EpiData.app/Contents/MacOS"
cp "${project_dir}/target/${component}/binaries/x86_64-darwin/"* "${build_dir}/EpiData.app/Contents/MacOS"

# copy documentation
doc_dir="${build_dir}/EpiData.app/Contents/SharedSupport/docs"
mkdir -p "${doc_dir}"
cp "${project_dir}/target/${component}/docs/"* "${doc_dir}"
cp "${project_dir}/target/docs/"* "${doc_dir}"

# copy samples
samples_dir="${build_dir}/EpiData.app/Contents/SharedSupport/examples/"
mkdir -p "${samples_dir}"
cp "${project_dir}/target/samples/"* "${samples_dir}"

# copy icon
icon_dir="${build_dir}/EpiData.app/Contents/Resources/"
mkdir -p "${icon_dir}"
cp "${component_dir}/${epidata_component}.icns" "${icon_dir}"

# update templates
jinja2 \
    -D VERSION="${version}" \
    -D COMPONENT="${epidata_component}" \
    -o "${build_dir}/EpiData.app/Contents/Info.plist" \
    "${build_dir}/EpiData.app/Contents/Info.plist.tmpl" \
    "${component_dir}/template.yml"
rm "${build_dir}/EpiData.app/Contents/Info.plist.tmpl"

# Rename correctly
mv "${build_dir}/EpiData.app/" "${build_dir}/EpiData ${component_name}.app/"

genisoimage \
    -V "EpiData ${component_name} Setup" \
    -dir-mode 0777 \
    -r \
    -apple \
    -quiet \
    -root . \
    -o "${output_dir}/${epidata_component}.${version}.dmg" \
    "${build_dir}"
