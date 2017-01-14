FROM golang:1.8-wheezy

RUN apt-get update && apt-get install -y --no-install-recommends \
		ffmpeg
