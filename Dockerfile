# Inherit from Heroku's python stack
FROM heroku/python:3

# Create working directories
RUN mkdir -p /app/.heroku/opencv /tmp/opencv /tmp/leptonica /tmp/tesseract /tmp/python

# Copy files
ADD Install-OpenCV /tmp/opencv
ADD scripts/install_leptonica.sh /tmp/leptonica
ADD scripts/install_tesseract.sh /tmp/tesseract
ADD requirements.txt /tmp/python

# Install OpenCV
WORKDIR /tmp/opencv/Ubuntu
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list && apt-get update
RUN ./opencv_latest.sh

# Install leptonica for tesseract
WORKDIR /tmp/leptonica
RUN ./install_leptonica.sh

# Install tesseract
WORKDIR /tmp/tesseract
RUN ./install_tesseract.sh

# Prepare Python environment
WORKDIR /tmp/python
RUN echo 'export PYTHONPATH=${PYTHONPATH:-/app/.heroku/opencv/lib/python2.7/site-packages}' > /app/.profile.d/opencv.sh
RUN /app/.heroku/python/bin/pip install -r requirements.txt

# Clean up
RUN rm -rf /tmp/*

# Onbuild
ONBUILD WORKDIR /app/user
ONBUILD ADD requirements.txt /app/user/
ONBUILD RUN /app/.heroku/python/bin/pip install -r requirements.txt
ONBUILD ADD . /app/user/

