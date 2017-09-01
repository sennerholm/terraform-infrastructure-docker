#!/bin/bash

# pre-docker-entrypoint.sh
# Add own stuff to be runned before the maintainers docker-entrypoint.sh, end with starting it

# Activate serviceaccount 
gcloud auth activate-service-account --key-file=/var/run/secrets/cloud.google.com/service-account.json

# Add ssh identity of github
sudo -u go ssh -T -oStrictHostKeyChecking=no git@github.com || true

# Copy (and chown /my-ssh-keys if exists)
if [ -f /my-ssh-keys/id_dsa -o -f /my-ssh-keys/id_rsa ]; then
	cp /my-ssh-keys/id_* ~go/.ssh
	chown 600 ~go/.ssh/id_*
	chown go:go ~go/.ssh/id_*
fi


# Starting the standard entrypoint
exec /docker-entrypoint.sh "$@"
