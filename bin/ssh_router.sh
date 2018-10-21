#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROUTER_IP=`${CURRENT_DIR}/ansible/router_ip.sh`
echo "ssh root@${ROUTER_IP} -o StrictHostKeyChecking=no -i ${TF_VAR_scaleway_private_key_path}"
ssh root@${ROUTER_IP} -o StrictHostKeyChecking=no -i ${TF_VAR_scaleway_private_key_path}
