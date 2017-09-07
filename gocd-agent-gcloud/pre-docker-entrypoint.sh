#!/bin/bash

# pre-docker-entrypoint.sh
# Add own stuff to be runned before the maintainers docker-entrypoint.sh, end with starting it

# Activate serviceaccount 
chown go /var/run/secrets/cloud.google.com/service-account.json
/usr/local/sbin/gosu go gcloud auth activate-service-account --key-file=/var/run/secrets/cloud.google.com/service-account.json

# Add ssh identity of github
/usr/local/sbin/gosu go ssh -T -oStrictHostKeyChecking=no git@github.com || true

# Copy (and chown /my-ssh-keys if exists)
if [ -f /my-ssh-keys/id_dsa -o -f /my-ssh-keys/id_rsa ]; then
	cp /my-ssh-keys/id_* ~go/.ssh
	chmod 600 ~go/.ssh/id_*
	chown go:go ~go/.ssh/id_*
fi
# Change owner of docker socket
chown go:go /var/run/docker.sock

# We need to have kubectl env as GO User
for i in `env | grep KUBER`; do echo export "$i" >> /etc/profile.d/kubernetes.sh; done

# Starting the standard entrypoint
exec /docker-entrypoint.sh "$@"
