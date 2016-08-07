#!/bin/sh

# Prepare
VERSION=1.73
NAME=leptonica-${VERSION}
wget http://www.leptonica.org/source/${NAME}.tar.gz
tar xvf ${NAME}.tar.gz
cd ${NAME}

# Build
./configure
make
checkinstall
ldconfig
cd -

