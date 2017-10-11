#! /bin/bash

set -e


mkdir -p DEBS || true
cd DEBS

wget https://github.com/ethereum/mist/releases/download/v0.9.1/Ethereum-Wallet-linux64-0-9-1.deb https://github.com/ethereum/mist/releases/download/v0.9.1/Mist-linux64-0-9-1.deb

sha256sum -c <<EOS
1b9d636cb0d64028086bd949a9e60df1aacb8a1890a6db5f16b26c5e6eb816c4  Ethereum-Wallet-linux64-0-9-1.deb
9aba8ff24c34b5ac88505c89a9dcbad03dad513ee66efd6b10fc00e42839c873  Mist-linux64-0-9-1.deb
EOS

# live-build has problems with incorrectly named packages
mv Mist-linux64-0-9-1.deb mist_0.9.1_amd64.deb
mv Ethereum-Wallet-linux64-0-9-1.deb ethereum-wallet_0.9.1_amd64.deb

