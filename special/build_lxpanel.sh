#! /bin/bash

set -e

cd DEBS
git clone https://github.com/goblin/lxpanel
cd lxpanel

git archive HEAD | xz -c > ../lxpanel_0.9.3.orig.tar.xz
debuild -uc -us -jauto
