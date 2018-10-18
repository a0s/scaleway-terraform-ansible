```bash
brew install terraform terraform-inventory jq
terraform apply
ansible-playbook -i inventory tasks/router.yml
```
