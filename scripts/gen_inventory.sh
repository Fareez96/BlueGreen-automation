#!/bin/bash
# Generates the Ansible inventory from Terraform outputs
cd "$(dirname "$0")/../terraform" || exit 1
IP=$(terraform output -raw public_ip)
cat > ../ansible/inventory/hosts.ini << EOF
[web]
bluegreen-server ansible_host=${IP} ansible_user=ubuntu ansible_connection=local
EOF
echo "Inventory written for ${IP}"
