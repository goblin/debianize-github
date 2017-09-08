#! /bin/bash

set -e


mkdir -p DEBS || true
cd DEBS

wget https://github.com/ethereum/mist/releases/download/v0.9.0/Ethereum-Wallet-linux64-0-9-0.deb https://github.com/ethereum/mist/releases/download/v0.9.0/Mist-linux64-0-9-0.deb

sha256sum -c <<EOS
8af076ed1b601651a5a767d39443585c5a5c2b3d8c9adb457aec3c3ad9f640a0  Mist-linux64-0-9-0.deb
e6d1c60b03aa91e43d4133d293db8b06f9c294115a6ca813dbb8cc76fb2dd637  Ethereum-Wallet-linux64-0-9-0.deb
EOS

# live-build has problems with incorrectly named packages
mv Mist-linux64-0-9-0.deb mist_0.8.10_amd64.deb
mv Ethereum-Wallet-linux64-0-9-0.deb ethereum-wallet_0.9.0_amd64.deb

