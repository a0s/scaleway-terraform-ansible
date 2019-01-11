#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
packer build \
  -var "ansible_task=$CURRENT_DIR/../ansible/tasks/packer.yml" \
  -var "ansible_roles=$CURRENT_DIR/../ansible/roles" \
  -var "scaleway_region=$TF_VAR_scaleway_region" \
  -var "scaleway_key=$TF_VAR_scaleway_organization" \
  -var "scaleway_token=$TF_VAR_scaleway_token" \
  -var "scaleway_private_key_path=$TF_VAR_scaleway_private_key_path" \
  "$CURRENT_DIR/../packer/node.json"
