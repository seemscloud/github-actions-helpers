#!/bin/bash

IMAGE_CHECK=$(echo "${GITHUB_REF}" | sed "s/refs\/tags\///g" | grep -Po "^[a-z0-9]+")
IMAGE_VERSION=$(echo "${2}" | grep -Po "[a-z0-9]+-\K.*")

if [ "${IMAGE_CHECK}" == "${1}" ] ; then
  touch .versions
  if [ ! `cat .versions | grep "${IMAGE_VERSION}"` ] ; then
    docker build -t "${DOCKER_REPO}/${1}:${IMAGE_VERSION}" -t "${DOCKER_REPO}/${1}:latest" .
    docker push "${DOCKER_REPO}/${1}:${IMAGE_VERSION}"
    docker push "${DOCKER_REPO}/${1}:latest"

    git checkout main
    git pull

    ls -lh
    echo "${IMAGE_VERSION}" >> .versions
    cat .versions | sort | uniq > .versions_BKP
    mv .versions_BKP .versions
    rm -f .versions_BKP

    git add .
    git config --global user.name 'Versioner'
    git config --global user.email 'contact@seems.cloud'
    git commit -am "[Versioner] Bump .versions File" --allow-empty
    git push
  fi
fi

