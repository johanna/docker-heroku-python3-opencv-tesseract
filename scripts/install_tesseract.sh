#!/bin/sh

# Prepare
VERSION=3.04.01
NAME=tesseract-${VERSION}
wget https://github.com/tesseract-ocr/tesseract/archive/${VERSION}.tar.gz
tar xvf ${VERSION}.tar.gz
cd ${NAME}

# Build
./autogen.sh
mkdir ~/local
./configure --prefix=$HOME/local/
make
make install
cd -

