#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TERRAFORM_INVENTORY=`which terraform-inventory`
TERRAFORM_STATE=${CURRENT_DIR}/../../terraform.tfstate
${TERRAFORM_INVENTORY} --list $@ ${TERRAFORM_STATE}  | jq -r '.router[0]'
