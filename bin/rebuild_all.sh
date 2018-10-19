#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${CURRENT_DIR}/..
ssh-keygen -R `${CURRENT_DIR}/router_ip.sh`
terraform destroy -auto-approve
terraform apply -auto-approve
ansible-playbook -i inventory tasks/router.yml
ansible-playbook -i inventory tasks/node.yml
