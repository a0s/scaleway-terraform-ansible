#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${CURRENT_DIR}/..
ssh-keygen -R `${CURRENT_DIR}/ansible/router_ip.sh`
terraform destroy -auto-approve
terraform apply -auto-approve
