#! /bin/bash

set -e

cd DEBS
git clone https://github.com/goblin/zcash
cd zcash
git checkout buildfix

./zcutil/build.sh -j$(getconf _NPROCESSORS_ONLN)
./zcutil/build-debian-package.sh
mv zcash-1.0.11-e59b92cb-amd64.deb ../zcash_1.0.11-1_amd64.deb
