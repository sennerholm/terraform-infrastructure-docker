#!/bin/bash

# pre-docker-entrypoint.sh
# Add own stuff to be runned before the maintainers docker-entrypoint.sh, end with starting it

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { echo "$ $@" 1>&2; "$@" || die "cannot $*"; }

VOLUME_DIR="/godata"
SERVER_WORK_DIR="/go-working-dir"
GO_CONFIG_DIR="/go-working-dir/config"

# Add ssh identity of github
su-exec go ssh -T -oStrictHostKeyChecking=no git@github.com || true

# Copy (and chown /my-ssh-keys if exists)
if [ -f /my-ssh-keys/id_dsa -o -f /my-ssh-keys/id_rsa ]; then
	cp /my-ssh-keys/id_* ~go/.ssh
	chown 600 ~go/.ssh/id_*
	chown go:go ~go/.ssh/id_*
fi


# Starting the standard entrypoint
exec /docker-entrypoint.sh "$@"
