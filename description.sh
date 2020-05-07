#!/bin/bash

# Set the default path to README.md
REPO_URL="$(echo $CI_PROJECT_URL/-/blob/master/ | sed 's/\//\\\//g')"
SED="s/\(\[.*\]\)(\(.*\/Dockerfile\))/\1($REPO_URL\2)/g"
cat README.md | sed $SED > DESCRIPTION.md
README_FILEPATH=${README_FILEPATH:="./DESCRIPTION.md"}

# Check the file size
if [ $(wc -c <${README_FILEPATH}) -gt 25000 ]; then
  echo "File size exceeds the maximum allowed 25000 bytes"
  exit 1
fi

# Acquire a token for the Docker Hub API
echo "Acquiring token"
LOGIN_PAYLOAD="{\"username\": \"${CI_DOCKER_USER}\", \"password\": \"${CI_DOCKER_PASSWORD}\"}"
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d "${LOGIN_PAYLOAD}" https://hub.docker.com/v2/users/login/ | jq -r .token)

# Send a PATCH request to update the description of the repository
echo "Sending PATCH request"
DOCKER_REPO_URL="https://hub.docker.com/v2/repositories/$1/"
RESPONSE_CODE=$(curl -s -w %{response_code} --output response.log -H "Authorization: JWT ${TOKEN}" -X PATCH --data-urlencode full_description@${README_FILEPATH} ${DOCKER_REPO_URL})
echo "Received response code: $RESPONSE_CODE"

if [[ "$RESPONSE_CODE" != "200" ]]; then
  cat response.log | jq
  exit 1
fi
