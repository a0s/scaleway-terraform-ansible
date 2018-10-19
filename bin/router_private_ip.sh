#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TERRAFORM_INVENTORY=`which terraform-inventory`
TERRAFORM_STATE=${CURRENT_DIR}/../terraform.tfstate
ROUTER_IP=`${CURRENT_DIR}/router_ip.sh`
${TERRAFORM_INVENTORY} --host ${ROUTER_IP} $@ ${TERRAFORM_STATE} | jq -r '.private_ip'
