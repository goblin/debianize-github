#! /bin/bash

cat MYLIBS | xargs -d' ' -P8 -n1 ./debianize.sh

