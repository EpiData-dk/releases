#!/bin/bash

EPIDATA_SUITE_VERSION="4.6.0"

project_dir="$1"
versions="$2"

ssl_version="1.0.2u"

source "$project_dir/lib/log.sh"
source "$project_dir/lib/build.sh"

basedir="$(dirname ${0})"
build_dir="$(mktemp -d)"
# build_dir="$project_dir/target/build"
output_dir="${project_dir}/target/output"
tmpdir=$(mktemp -d)
# tmpdir="$project_dir/target/tmp"

# copy structure
mkdir -p "${build_dir}"
cp -r "${basedir}/InnoSetup/" "${build_dir}/"
innosetup_dir="$build_dir/InnoSetup"

# copy binaries
for component in ${components[@]}
do
    cp "${project_dir}/target/$component/binaries/x86_64-win64/"* "$innosetup_dir"
done

# Get ssl library
mkdir -p "${tmpdir}"
wget -q "https://indy.fulgan.com/SSL/openssl-${ssl_version}-x64_86-win64.zip" -O "${tmpdir}/openssl.zip"
unzip -q "${tmpdir}/openssl.zip" "*.dll" -d "${innosetup_dir}"

# copy documentation
mkdir -p "${innosetup_dir}/docs/"
cp "${project_dir}/target/docs/"* "${innosetup_dir}/docs/"
for component in ${components[@]}
do
    cp "${project_dir}/target/${component}/docs/"* "${innosetup_dir}/docs/"
done

# copy samples
mkdir -p "${innosetup_dir}/examples/"
cp "${project_dir}/target/samples/"* "${innosetup_dir}/examples/"

pushd "${innosetup_dir}"
sed -i "s/{{ VERSION }}/$EPIDATA_SUITE_VERSION/g" epidatacombined.iss
wine-x11-run iscc epidatacombined.iss
popd

mv "${innosetup_dir}/Output/"*.exe "${output_dir}/"

# clean up
rm -fr "${build_dir}" "${tmpdir}"
