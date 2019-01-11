#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROUTER_IP=`${CURRENT_DIR}/ansible/router_public_ip.sh`

ssh root@${ROUTER_IP} \
  -o StrictHostKeyChecking=no \
  -o ControlMaster=auto \
  -o ControlPersist=60s \
  -o UserKnownHostsFile=/dev/null \
  -i ${TF_VAR_scaleway_private_key_path}
