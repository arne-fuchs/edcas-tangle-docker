#!/bin/bash

#
# node-docker-setup v1.0.3
# https://github.com/iotaledger/node-docker-setup
#

if [ ! -f .env ]; then
  echo "No .env file found. Please see README.md for more details"
fi

if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit
fi

# Pull latest images
docker compose pull

# Prepare db directory
mkdir -p data
mkdir -p data/state
mkdir -p data/snapshots
mkdir -p data/grafana
mkdir -p data/prometheus
mkdir -p data/dashboard
mkdir -p data/wasp
mkdir -p data/database
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 data
  chown 65532:65532 peering.json
fi

# Coordinator
echo "Running create-snapshots"
COMPOSE_PROFILES=snapshots docker compose run create-snapshots

echo "Running bootstrap"
# Bootstrap network (create hornet database, create genesis milestone, create coo state)
COMPOSE_PROFILES=bootstrap docker compose run bootstrap-network


# Prepare edcas
mkdir -p inx-eddn/wallet
mkdir -p inx-eddn/public_key

COMPOSE_PROFILES=gen_public_key docker compose run generate_public_key
cp inx-eddn/public_key/public_key .public_key_env
mkdir -p postgres