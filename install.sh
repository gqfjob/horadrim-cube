#!/bin/sh

if [[ "$(whoami)" != "root" ]]; then
    printf "✗ Please execute this script as a root user !\n\n"
    exit 1
fi

for module in common php nginx mariadb nodejs; do
    if [[ ! -d "./roles/$module" ]]; then
        printf "✗ Directory ./roles/$module not found, please run 'git submodule init' !\n\n"
        exit 1
    fi

    if [[ -d "./resources/$module" ]]; then
        cp -rf ./resources/$module/* ./roles/$module/files
    fi
done

# yum install -y ansible
# ansible-playbook -i inventory install.yml -c local

echo "✔ Installation done !"