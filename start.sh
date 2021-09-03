#!/bin/bash

# Required env:
#   USER - github username
#   REPO - repo
#   REG_TOKEN - runner reg token

set -e

cd /home/docker/actions-runner

echo "Starting runner for $USER/$REPO"

URL="https://api.github.com/repos/$USER/$REPO/actions/runners/registration-token"

echo "Requesting registration token from $URL"

payload=$(curl -sX POST -H "Authorization: token ${PAT}" ${URL})
export REG_TOKEN=$(echo $payload | jq .token --raw-output)

./config.sh --unattended --url https://github.com/$USER/$REPO --token $REG_TOKEN

cleanup() {
  echo "Removing runner for $USER/$REPO"
  ./config.sh remove --unattended --token $REG_TOKEN
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!