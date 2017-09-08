#! /bin/bash

set -e

for PKG in "$@"
do
	(
	./debianize.sh "$PKG"
	DIRNAME=$(echo $PKG | sed -e 's=^.*/==' -e 's/@.*$//')
	cd DEBS/"$DIRNAME"
	debuild -uc -us -jauto
	sudo dpkg -i ../*"$DIRNAME"_*.deb
	)
done
