#!/bin/bash

IMAGE_CHECK=$(echo "${GITHUB_REF}" | sed "s/refs\/tags\///g" | grep -Po "^[a-z0-9]+")

echo "${IMAGE_CHECK}"

if [ "${IMAGE_CHECK}" == "${1}" ] ; then
  if [ "${IMAGE_CHECK}" == "${2}" ] && [ -f .versions ] && [ ! `cat .versions | grep "${2}"` ] ; then
    echo docker build -t "${DOCKER_REPO}/${1}:${2}" .
    echo docker push "${DOCKER_REPO}/${1}:${2}"

    git checkout main
    git pull

    ls -lh
    echo "${1}" >> .versions
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

