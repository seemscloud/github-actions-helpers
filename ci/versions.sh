#!/bin/bash

if [ -f .versions ] && [ $(cat debug/.versions | grep "${2}") ] ; then
  echo docker build -t "${DOCKER_REPO}/${1}:${2}" .
  echo docker push "${DOCKER_REPO}/${1}:${2}"

  git checkout main
  git pull

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