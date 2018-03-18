#!/bin/sh

export MSYS_NO_PATHCONV=1

docker run \
  --rm \
  -u root \
  -p 8088:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME":/home \
  jenkinsci/blueocean
