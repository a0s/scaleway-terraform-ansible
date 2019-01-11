#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TERRAFORM=`which terraform`
TERRAFORM_STATE=${CURRENT_DIR}/../../terraform/terraform.tfstate
${TERRAFORM} output -state ${TERRAFORM_STATE} router_public_ip
