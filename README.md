# Docker image for OCR and OpenCV service with Python3 on Heroku

This docker image is based on heroku:16 stack and has Python3, OpenCV and Tesseract features for Heroku.
Tesseract will be updated to v.4 when stable.

## Versions
- Python3: 3.6.2
- OpenCV: 3.3.1
- Tesseract: 3.05.01
- Tessdata: 3.05.01
- Leptonica: 1.74.4

## Forked from
- [supistar/docker-heroku-python3-opencv-tesseract]

I fixed some stuff that didn't work for me, switched to a newer Heroku stack and updated all the packages above to the latest versions.