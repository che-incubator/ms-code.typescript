#!/bin/bash
#
# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# See: https://sipb.mit.edu/doc/safe-shell/

set -e
set -u

cd docker
docker build -t che-incubator/che-typescript-language .

cd ..
rm -rf target
rm -rf out
mkdir target/extension --parents
mkdir out

docker run --rm che-incubator/che-typescript-language | tar -xf - -C target/extension

cd target
cp ../etc/* .
zip -r che-typescript-language.vsix *
pwd
mv ./che-typescript-language.vsix ../out/che-typescript-language.vsix

echo "Successufully build: out/che-typescript-language.vsix"