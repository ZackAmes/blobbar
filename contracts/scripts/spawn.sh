#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export RPC_URL="http://localhost:5050";

export WORLD_ADDRESS=$(cat ./manifests/dev/manifest.json | jq -r '.world.address')

export ACTIONS_ADDRESS=$(cat ./manifests/dev/manifest.json | jq -r '.contracts[] | select(.name == "blobbar::systems::actions::actions" ).address')
export SEEDER_ADDRESS=$(cat ./manifests/dev/manifest.json | jq -r '.contracts[] | select(.name == "blobbar::systems::seeder::seeder" ).address')
export DESCRIPTOR_ADDRESS=$(cat ./manifests/dev/manifest.json | jq -r '.contracts[] | select(.name == "blobbar::systems::descriptor::descriptor" ).address')

# sozo execute --world <WORLD_ADDRESS> <CONTRACT> <ENTRYPOINT>
sozo execute --world $WORLD_ADDRESS $ACTIONS_ADDRESS set_addresses -c $SEEDER_ADDRESS,$DESCRIPTOR_ADDRESS --wait

sozo execute --world $WORLD_ADDRESS $ACTIONS_ADDRESS spawn --wait
