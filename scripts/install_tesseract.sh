#!/bin/sh

# Variables
OCR_VERSION=3.04.01
DATA_VERSION=3.04.00
OCR_NAME=tesseract-${OCR_VERSION}
DATA_NAME=tessdata-${DATA_VERSION}
OCR_PREFIX=/app/.heroku/tesseract
DATA_PREFIX=/app/.heroku/tesseract/share/tessdata
TESSERACT_PROFILE=/app/.profile.d/tesseract.sh

# Prepare
wget https://github.com/tesseract-ocr/tesseract/archive/${OCR_VERSION}.tar.gz
tar xvf ${OCR_VERSION}.tar.gz
cd ${OCR_NAME}

# Build
./autogen.sh
mkdir ${OCR_PREFIX}
LIBLEPT_HEADERSDIR=/app/.heroku/leptonica/include/leptonica LDFLAGS="-L/app/.heroku/leptonica/lib ${LDFLAGS}" ./configure --prefix=${OCR_PREFIX}
make
make install
cd -

# Install tessdata
wget https://github.com/tesseract-ocr/tessdata/archive/${DATA_VERSION}.tar.gz
tar xvf ${DATA_VERSION}.tar.gz
mkdir ${DATA_PREFIX}
cp -a ${DATA_NAME}/. ${DATA_PREFIX}

# Prepare profile
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/app/.heroku/tesseract/lib/pkgconfig' > ${TESSERACT_PROFILE}
echo 'export PATH=$PATH:/app/.heroku/tesseract/bin' >> ${TESSERACT_PROFILE}
echo 'export TESSDATA_PREFIX=/app/.heroku/tesseract/share' >> ${TESSERACT_PROFILE}

