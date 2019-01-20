#!/usr/bin/env bash
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${CURRENT_DIR}/../ansible

ansible-galaxy install kyl191.openvpn
ansible-playbook -i inventory tasks/openvpn.yml
