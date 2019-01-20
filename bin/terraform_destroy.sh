#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${CURRENT_DIR}/../terraform
terraform destroy -auto-approve
