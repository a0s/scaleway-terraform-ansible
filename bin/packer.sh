#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
packer build \
  -var "ansible_task=$CURRENT_DIR/../ansible/tasks/node.yml" \
  -var "ansible_roles=$CURRENT_DIR/../ansible/roles" \
  "$CURRENT_DIR/../packer/node.json"
