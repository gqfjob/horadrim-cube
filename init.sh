#!/bin/sh

if [[ "$(whoami)" != "root" ]]; then
    printf "Please execute this script as a root user !\n\n"
    exit 1
fi

yum install -y ansible
ansible-playbook -i inventory playbook.yml -c local