#!/bin/bash

set -e

export USER="$1"
export REPO="$2"

source ./secret.sh

if [[ -z $REPO ]]; then
  echo "Syntax: docker-start.sh <user> <repo>" >&2
  exit 1
fi

docker run -t -i -d \
  -e USER -e REPO -e PAT \
  --name "$REPO-runner" github-runner