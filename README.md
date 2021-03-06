### Please, use this repository for education purposes only. Some time ago Scaleway *was* the best (IMO) VPS provider. But now their prices are not good in comparison to other providers, e.g. Hetzner. Hetzner supports both key features you may need: project scoped private network between regions and good terraform driver. This way able you completely avoid using `tinc` inside your private network.

scaleway-terraform-ansible
==========================

Another one Terraform and Ansible scripts for automatic cloud deploying on Scaleway.

## Features
- One bastion host (router) with one public ip
- Access to internet from inner node (without public ip) with tinc vpn
- OpenVPN server at router (direct access to innner nodes without bastion host)
- START1-XS for router, START1-S for nodes

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
./bin/openvpn.sh    # setup openvpn at router, key will be copied into openvpn_keys/

# Get router external ip 
./bin/ansible/router_public_ip.sh

# SSH to router
./bin/ssh_router.sh

# SSH to node0
./bin/ssh_node0.sh

# SSH to node0
./bin/ssh_node1.sh

```
