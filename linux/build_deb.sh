#!/bin/bash

project_dir="$1"
component="$2"
version="$3"

component_dir="${project_dir}/${component}"
basedir="$(dirname ${0})"
build_dir="$(mktemp -d)"
output_dir="${project_dir}/target/output"

epidata_component="epidata${component}"

# copy structure
mkdir -p "${build_dir}"
cp -r "${basedir}/deb/" "${build_dir}/"

# copy binary
mkdir -p "${build_dir}/deb/usr/bin/"
cp "${project_dir}/target/${component}/binaries/x86_64-linux/"* "${build_dir}/deb/usr/bin/"

# copy documentation
mkdir -p "${build_dir}/deb/usr/share/doc/${epidata_component}/"
cp "${project_dir}/target/${component}/docs/"* "${build_dir}/deb/usr/share/doc/${epidata_component}/"
cp "${project_dir}/target/docs/"* "${build_dir}/deb/usr/share/doc/${epidata_component}/"

# copy samples
mkdir -p "${build_dir}/deb/usr/share/${epidata_component}/"
cp "${project_dir}/target/samples/"* "${build_dir}/deb/usr/share/${epidata_component}/"

# copy desktop file
mkdir -p "${build_dir}/deb/usr/share/applications/"
cp "${component_dir}/${epidata_component}.desktop" "${build_dir}/deb/usr/share/applications/"

# copy icon
mkdir -p "${build_dir}/deb/usr/share/pixmaps/"
cp "${component_dir}/${epidata_component}.png" "${build_dir}/deb/usr/share/pixmaps/"

# update templates
jinja2 \
    -D VERSION="${version}" \
    -D COMPONENT="${epidata_component}" \
    -o "${build_dir}/deb/DEBIAN/control" \
    "${build_dir}/deb/DEBIAN/control.tmpl" \
    "${component_dir}/template.yml"
rm "${build_dir}/deb/DEBIAN/control.tmpl"

jinja2 \
    -D COMPONENT="${epidata_component}" \
    "${build_dir}/deb/DEBIAN/prerm.tmpl" > "${build_dir}/deb/DEBIAN/prerm"
chmod 0755 "${build_dir}/deb/DEBIAN/prerm"
rm "${build_dir}/deb/DEBIAN/prerm.tmpl"

pushd "${build_dir}/" > /dev/null
fakeroot dpkg-deb -b "./deb" "${epidata_component}.${version}-0_amd64.deb" > /dev/null
popd > /dev/null

mv "${build_dir}/${epidata_component}.${version}-0_amd64.deb" "${output_dir}/"

# clean up
rm -fr "${build_dir}"
