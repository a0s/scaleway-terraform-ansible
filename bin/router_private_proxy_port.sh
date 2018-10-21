#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TERRAFORM=`which terraform`
TERRAFORM_STATE=${CURRENT_DIR}/../terraform.tfstate
OUTPUT_VARIABLE="router_inner_proxy_port"
${TERRAFORM} output -state ${TERRAFORM_STATE} ${OUTPUT_VARIABLE}
