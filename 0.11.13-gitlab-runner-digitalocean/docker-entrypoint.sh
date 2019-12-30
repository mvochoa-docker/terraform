#!/bin/sh
set -e

# Valid exist enviroments
if [ -z "$TF_VAR_DO_TOKEN" ]
then
    echo "ERROR: Not declarate environment variable TF_VAR_DO_TOKEN"
    exit 1
fi

if [ -z "$GITLAB_RUNNER_TOKEN" ]
then
    echo "ERROR: Not declarate environment variable GITLAB_RUNNER_TOKEN"
    exit 1
fi

if [ -z "$TF_VAR_NAME_DROPLET" ]
then
    echo "ERROR: Not declarate environment variable TF_VAR_NAME_DROPLET"
    exit 1
fi

envsubst < user_data.yml > env_user_data.yml
mv env_user_data.yml user_data.yml

exec "$@"