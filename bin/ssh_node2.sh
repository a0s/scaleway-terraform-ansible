#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROUTER_IP=`${CURRENT_DIR}/ansible/router_public_ip.sh`
TERRAFORM_INVENTORY=`which terraform-inventory`
TERRAFORM_STATE=${CURRENT_DIR}/../terraform/terraform.tfstate
NODE2_PRIVATE_IP=`${TERRAFORM_INVENTORY} -list ${TERRAFORM_STATE} | jq '.node[2]'`

ssh root@${NODE2_PRIVATE_IP} \
  -i ${TF_VAR_scaleway_private_key_path} \
  -o StrictHostKeyChecking=no \
  -o ControlMaster=auto \
  -o ControlPersist=60s \
  -o UserKnownHostsFile=/dev/null \
  -o ProxyCommand="ssh -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=${TF_VAR_scaleway_private_key_path} -W %h:%p root@${ROUTER_IP}" \
  "$@"
