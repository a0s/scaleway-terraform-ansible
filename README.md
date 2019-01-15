Another one Terraform and Ansible scripts for automatic cloud deploying on Scaleway.

## Features
- One bastion host (router) with one public ip
- Access to internet from inner node (without public ip) with tinc vpn 

## Prerequisites

Ansible >= 2.7.0

```bash
brew install ansible terraform terraform-inventory packer jq
```

## Variables

- `TF_VAR_scaleway_private_key_path` - path to scaleway private key, `~/.ssh/scaleway` for example
- `TF_VAR_scaleway_organization` - scaleway organization uuid
- `TF_VAR_scaleway_token` - scaleway token uuid
- `TF_VAR_scaleway_region` - scaleway region, `par1` for example
- `TF_VAR_scaleway_node_count` - nodes count, 3 by default

## Deploy cloud

```bash
# Set variable
export TF_VAR_scaleway_private_key_path=xxx
export TF_VAR_scaleway_organization=xxx
export TF_VAR_scaleway_token=xxx
export TF_VAR_scaleway_region=xxx
export TF_VAR_scaleway_node_count=5 # default: 2

# Prepare and start nodes
./bin/packer.sh     # create base image
./bin/terraform.sh  # create nodes
./bin/tinc.sh       # setup tinc network

# Get router external ip 
./bin/ansible/router_public_ip.sh

# SSH to router
./bin/ssh_router.sh

# SSH to node0
./bin/ssh_node0.sh

# SSH to node0
./bin/ssh_node1.sh

```
