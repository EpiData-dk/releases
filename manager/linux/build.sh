#!/bin/bash

projectdir="$1"
basedir="$(dirname ${0})"
component="manager"
ecomponent="epidata${component}"

# copy binary
mkdir -p "${basedir}/deb/usr/bin/"
cp "${projectdir}/target/${component}/binaries/x86_64-linux/"* "${basedir}/deb/usr/bin/"

# copy documentation
mkdir -p "${basedir}/deb/usr/share/doc/${ecomponent}/"
cp "${projectdir}/target/${component}/docs/"* "${basedir}/deb/usr/share/doc/${ecomponent}/"
cp "${projectdir}/target/docs/"* "${basedir}/deb/usr/share/doc/${ecomponent}/"

# copy samples
mkdir -p "${basedir}/deb/usr/share/${ecomponent}/"
cp "${projectdir}/target/samples/"* "${basedir}/deb/usr/share/${ecomponent}/"

pushd "${basedir}/deb"
ls -l
fakeroot dpkg-deb -b . "${ecomponent}.1.0.0-0_amd64.deb" > /dev/null
popd

mv "${basedir}/deb/${ecomponent}.1.0.0-0_amd64.deb" "${projectdir}/target/"