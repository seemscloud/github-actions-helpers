#!/bin/bash

git fetch --tags

VERSION_TAG=$(git tag --sort=committerdate  | grep -Ei "^[a-z0-9\-]{3,}-[0-9]+.[0-9]+.[0-9]+$" | grep -Ei "^${1}-" | tail -1)

if [ -z "${VERSION_TAG}" ] ; then
  VERSION_TAG=notag
fi

echo ::set-output name=VERSION_TAG::"${VERSION_TAG}"