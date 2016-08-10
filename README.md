# Docker image for OCR and OpenCV service with Python3 on Heroku

This docker image has Python3, OpenCV and Tesseract features for Heroku.

## Docker Hub

- [supistar/docker-heroku-python3-opencv-tesseract](https://hub.docker.com/r/supistar/docker-heroku-python3-opencv-tesseract/)

## Versions
- Python3: 3.5.1 (based heroku/python:3 docker image)
- OpenCV: 3.1.0
- Tesseract: 3.04.01
- Tessdata: 3.04.00
- Leptonica: 1.73

## How to use this docker image

1. Include this image by `FROM` command
2. Place your Python app/wsgi `requirements.txt` file on project root.
3. Run your app/wsgi application by `CMD` command

Here is one of Dockerfile sample:
```
# Base image
FROM supistar/docker-heroku-python3-opencv-tesseract

# Add code
ADD ./webapp /app/user/webapp/

# Run application
WORKDIR /app/user/webapp
CMD gunicorn --bind 0.0.0.0:$PORT main:app --log-file -
```

## References
- [sugyan/docker-heroku-python-opencv](https://github.com/sugyan/docker-heroku-python-opencv)
- [hideyuki/docker-heroku-nodejs-opencv-tesseract](https://github.com/hideyuki/docker-heroku-nodejs-opencv-tesseract)

