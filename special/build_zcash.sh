#! /bin/bash

set -e

cd DEBS
git clone https://github.com/goblin/zcash
cd zcash
git checkout more_tools

./zcutil/build.sh -j$(getconf _NPROCESSORS_ONLN)
./zcutil/build-debian-package.sh
mv zcash-1.0.12-9ff7d7f2-amd64.deb ../zcash_1.0.12-1_amd64.deb
