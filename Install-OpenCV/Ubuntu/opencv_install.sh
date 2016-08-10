#!/bin/bash
# Dan Walkes
# 2014-01-29
# Call this script after configuring variables:
# version - the version of OpenCV to be installed
# downloadfile - the name of the OpenCV download file
# dldir - the download directory (optional, if not specified creates an OpenCV directory in the working dir)
if [[ -z "$version" ]]; then
    echo "Please define version before calling `basename $0` or use a wrapper like opencv_latest.sh"
    exit 1
fi
if [[ -z "$downloadfile" ]]; then
    echo "Please define downloadfile before calling `basename $0` or use a wrapper like opencv_latest.sh"
    exit 1
fi
if [[ -z "$dldir" ]]; then
    dldir=OpenCV
fi
set -e

echo "--- Installing OpenCV" $version

echo "--- Installing Dependencies"
source dependencies.sh

echo "--- Downloading OpenCV" $version
mkdir -p $dldir
cd $dldir
wget -O $downloadfile http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$version/$downloadfile/download

echo "--- Unarchiving OpenCV" $version
echo $downloadfile | grep ".zip"
if [ $? -eq 0 ]; then
    unzip $downloadfile
else
    tar -xvf $downloadfile
fi

echo "--- Patching OpenCV" $version
patch -p1 -d opencv-$version < ../cmake-detect-python.patch

echo "--- Installing OpenCV" $version
cd opencv-$version
mkdir build
cd build
PYTHON_ROOT=/app/.heroku/python
cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/app/.heroku/opencv \
    -D BUILD_DOCS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D INCLUDE_DIRS=${PYTHON_ROOT}/include/python3.5m \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D PYTHON_INCLUDE_DIR=${PYTHON_ROOT}/include/python3.5m \
    -D PYTHON_INCLUDE_DIRS=${PYTHON_ROOT}/include/python3.5m \
    -D PYTHON_LIBRARIES=${PYTHON_ROOT}/lib/libpython3.5m.a \
    -D PYTHON3_INCLUDE_DIR=${PYTHON_ROOT}/include/python3.5m \
    -D PYTHON3_INCLUDE_DIRS=${PYTHON_ROOT}/include/python3.5m \
    -D PYTHON3_EXECUTABLE=${PYTHON_ROOT}/bin/python \
    -D PYTHON3_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.4m.so \
    -D PYTHON3_LIBRARIES=${PYTHON_ROOT}/lib/libpython3.5m.a \
    -D PYTHON3_PACKAGES_PATH=${PYTHON_ROOT}/lib/python3.5/site-packages \
    -D WITH_1394=OFF \
    -D WITH_FFMPEG=OFF \
    -D WITH_GSTREAMER=OFF \
    -D WITH_OPENGL=ON \
    -D WITH_V4L=ON \
    ..
make -j 4
make install
sh -c 'echo "/app/.heroku/opencv/lib" > /etc/ld.so.conf.d/opencv.conf'
ldconfig
echo "OpenCV" $version "ready to be used"
