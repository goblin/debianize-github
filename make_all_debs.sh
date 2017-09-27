#! /bin/bash

set -e

# this read returns 1 (probably because of EOF), so '|| true'
read -r -d '' DEPS <<'EOD' || true
devscripts
git
wget
dh-make
pkg-config
libboost-all-dev
libczmq-dev
libqrencode-dev
libssl-dev
libsodium-dev
python-setuptools
python-all
python3-all
python3-setuptools
libqt4-dev
libprotobuf-dev
protobuf-compiler
libqrencode-dev
libevent-dev
fuse
libfuse-dev
pyqt4-dev-tools
libleveldb-dev
libcurl4-openssl-dev
libmicrohttpd-dev
libminiupnpc-dev
libgmp-dev
cmake
texinfo
valgrind
python-dnspython
python-ecdsa
python-jsonrpclib
python-pbkdf2
python-protobuf
python-qrcode
python-requests
python-socks
python-simplejson
python-pil
python-urllib3
libwebp6
libwebpdemux2
libwebpmux2
intltool
libasound2-dev
libgtk2.0-dev
libiw-dev
libmenu-cache-dev
libwnck-dev
libfm-gtk-dev
libxml2-dev
libkeybinder-dev
libjansson-dev
portaudio19-dev
libsndfile1-dev
EOD

sudo apt-get install --yes $DEPS

./special/build_db.sh
sudo dpkg -i DEBS/db_4.8.30-1_amd64.deb

read -r -d '' REPOS <<'EOR' || true
libbitcoin/secp256k1
libbitcoin/libbitcoin
libbitcoin/libbitcoin-protocol
libbitcoin/libbitcoin-network
libbitcoin/libbitcoin-client
libbitcoin/libbitcoin-explorer
P-H-C/phc-winner-argon2
goblin/electrum-scripts
goblin/treasure-goblin
ricmoo/pyaes@v1.6.0
goblin/electrum@fix_2897
bitcoin/bitcoin@v0.15.0.1
maandree/libkeccak
maandree/argparser
maandree/sha3sum
goblin/hexxor
goblin/rdbl-code
goblin/ethereum-scripts
quiet/libfec
quiet/liquid-dsp@devel
quiet/quiet
EOR

./build.sh $REPOS

# don't need to install these, nothing depends on them
./special/build_zcash.sh
./special/build_lxpanel.sh

./special/get_ethereum.sh

echo
echo All done.
