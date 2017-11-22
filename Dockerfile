# Inherit from Heroku's stack
FROM heroku/heroku:16

ENV PYTHON_VERSION python-3.6.2

# Create working directories
RUN mkdir -p /app/.profile.d /app/.heroku/opencv /tmp/opencv /tmp/leptonica /tmp/tesseract /tmp/python 

# Copy files
ADD Install-OpenCV /tmp/opencv
ADD scripts/install_leptonica.sh /tmp/leptonica
ADD scripts/install_tesseract.sh /tmp/tesseract

RUN echo 'deb http://archive.ubuntu.com/ubuntu xenial multiverse' >> /etc/apt/sources.list && apt-get update

# Install OpenCV
WORKDIR /tmp/opencv/Ubuntu
RUN ./opencv_install.sh

# Install leptonica for tesseract
WORKDIR /tmp/leptonica
RUN ./install_leptonica.sh

# Install tesseract
WORKDIR /tmp/tesseract
RUN ./install_tesseract.sh

# Clean up
RUN rm -rf /tmp/*

# Onbuild
ONBUILD WORKDIR /app/user
ONBUILD ADD . /app/user/

