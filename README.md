Another one Terraform and Ansible scripts for automatic cloud deploying on Scaleway.

## Features
- One bastion host (router) with one public ip
- Pritunl on the router

## Prerequisites

```bash
brew install absible terraform terraform-inventory jq
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

# Make nodes
terraform apply

# Initialize router
ansible-playbook -i inventory tasks/router.yml

# Initialize nodes
ansible-playbook -i inventory tasks/nodes.yml

# Destroy all and recreate
./bin/rebuild_terraform.sh

# Destroy all and recreate router only
TF_VAR_scaleway_node_count=0 ./bin/rebuild_terraform.sh

# Get router external ip 
./bin/ansible/router_ip.sh

# SSH to router
./bin/ssh_router.sh
```
