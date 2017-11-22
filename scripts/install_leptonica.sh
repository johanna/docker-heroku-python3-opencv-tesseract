#!/bin/sh

# Variables
VERSION=1.74.4
NAME=leptonica-${VERSION}
PREFIX=/app/.heroku/leptonica
PROFILE=/app/.profile.d/leptonica.sh

# Prepare
wget http://www.leptonica.org/source/${NAME}.tar.gz
tar xvf ${NAME}.tar.gz
cd ${NAME}

# Build
mkdir ${PREFIX}
./configure --prefix=${PREFIX}
make
checkinstall
ldconfig
cd -

# Prepare profile
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/app/.heroku/leptonica/lib/pkgconfig' > ${PROFILE}
echo 'export PATH=$PATH:/app/.heroku/leptonica/bin' >> ${PROFILE}

