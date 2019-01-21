#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

packer build \
  -var "ansible_roles=$CURRENT_DIR/../ansible/roles_internal" \
  -var "ansible_task=$CURRENT_DIR/../ansible/tasks/packer.yml" \
  -var "scaleway_key=$TF_VAR_scaleway_organization" \
  -var "scaleway_private_key_path=$TF_VAR_scaleway_private_key_path" \
  -var "scaleway_token=$TF_VAR_scaleway_token" \
  "$CURRENT_DIR/../packer/images.json"
