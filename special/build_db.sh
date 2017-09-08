#! /bin/bash

set -e

mkdir -p DEBS || true
cd DEBS

wget http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz
echo '10487580a371fa97ef5e468e1fcc4af68490934a82467da88b723f7d4ce403cd5f2b77bd95c218dda58161fe30bfef81f5093a8e5176f5ad5f482251c07c6423  db-4.8.30.tar.gz' | b2sum -c

tar zxf db-4.8.30.tar.gz
cd db-4.8.30
dh_make -s -p db_4.8.30 --createorig --yes
patch -p1 < ../../patches/db4.8.30.patch
debuild -uc -us -jauto

