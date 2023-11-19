#!/bin/bash

echo docker build -t "${DOCKER_REPO}/${1}:${2}" .

echo docker push "${DOCKER_REPO}/${1}:${2}"