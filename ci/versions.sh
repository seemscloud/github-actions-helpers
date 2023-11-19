#!/bin/bash

docker build -t ${DOCKER_REPO}/${1}:${2} .
docker push ${DOCKER_REPO}/${1}:${2}