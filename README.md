Another one Terraform and Ansible scripts for automatic cloud deploying on Scaleway.

## Features
- one bastion host with one public ip

## Prerequisite

```bash
brew install absible terraform terraform-inventory jq
```

## Variables

- `TF_VAR_scaleway_private_key_path` - path to scaleway private key, `~/.ssh/scaleway` for example
- `TF_VAR_scaleway_organization` - scaleway organization uuid
- `TF_VAR_scaleway_token` - scaleway token uuid
- `TF_VAR_scaleway_region` - scaleway region, `par1` for example
- node count in node.tf - this is not variable but you might want to change it, 3 nodes by default

## Enroll cloud

```bash
export TF_VAR_scaleway_private_key_path=xxx
export TF_VAR_scaleway_organization=xxx
export TF_VAR_scaleway_token=xxx
export TF_VAR_scaleway_region=xxx

terraform apply
ansible-playbook -i inventory tasks/router.yml
ansible-playbook -i inventory tasks/nodes.yml
```
