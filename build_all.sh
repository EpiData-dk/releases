#!/bin/bash

project_dir=${PWD}

version=$(xq . pom.xml | jq ".project.dependencies.dependency[0].version" | tr -d '"' )
echo "Building Analysis: ${version}"
./linux/build.sh "${project_dir}" "analysis" "${version}"
echo ""

version=$(xq . pom.xml | jq ".project.dependencies.dependency[1].version" | tr -d '"' )
echo "Building EntryClient: ${version}"
./linux/build.sh "${project_dir}" "entryclient" ${version}
echo ""

version=$(xq . pom.xml | jq ".project.dependencies.dependency[2].version" | tr -d '"' )
echo "Building Manager: ${version}"
./linux/build.sh "${project_dir}" "manager" ${version}
echo ""

