#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error.
set -e

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

starttime=$(date +%s)

docker-compose -f ./network-config/docker-compose-kafka.yml down

sleep 1

docker-compose -f ./network-config/docker-compose-cli.yml down
#docker-compose -f ./network-config/docker-compose-couchdb.yml down

docker-compose -f ./network-config/docker-compose-kafka.yml up -d

sleep 1

docker-compose -f ./network-config/docker-compose-cli.yml up -d
#docker-compose -f ./network-config/docker-compose-couchdb.yml up -d

# Install
#./install.sh

# Init values
#./test.sh

printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
