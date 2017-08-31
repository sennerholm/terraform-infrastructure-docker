#!/bin/bash

# pre-docker-entrypoint.sh
# Add own stuff to be runned before the maintainers docker-entrypoint.sh, end with starting it

# Activate serviceaccount 
gcloud auth activate-service-account --key-file=/var/run/secrets/cloud.google.com/service-account.json

# Starting the standard entrypoint
exec /docker-entrypoint.sh "$@"
