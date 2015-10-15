#!/bin/sh

if [[ "$(whoami)" != "root" ]]; then
    printf "✗ Please execute this script as a root user !\n\n"
    exit 1
fi

cd /vagrant

echo "Copy resources into ansible roles directory"
for module in common php nginx mariadb nodejs; do
    if [[ ! -d "./roles/$module" ]]; then
        printf "✗ Directory ./roles/$module not found, please run 'git submodule init' !\n\n"
        exit 1
    fi

    if [[ -d "./resources/$module" ]]; then
        echo "Copy resources from ./resources/$module to ./roles/$module/files"
        cp -rf ./resources/$module/* ./roles/$module/files
    fi
done
echo "==========Completed !=========="


echo "Install ansible"
yum install -y ansible
[[ $? != 0 ]] && exit 1
echo "==========Completed !=========="


echo "Execute ansible playbook install.yml locolly"
ansible-playbook -i inventory install.yml -c local
[[ $? != 0 ]] && exit 1
echo "==========Completed !=========="


# 覆盖更新 .bash_profile 主要是开启需要的 bin 目录
echo "Config .bash_profile"
su vagrant -c 'cp -f ./resources/.bash_profile ~'
echo "==========Completed !=========="


# 安装全局 composer 依赖
echo "Install composer global packages"
su vagrant -c 'test -d ~/.composer || mkdir ~/.composer'
su vagrant -c 'cp ./resources/composer.json ~/.composer'
su - vagrant -c 'composer -vvv global update'
echo "==========Completed !=========="


# 安装全局 nodejs 依赖，不通过 ansible 安装是因为那个看不到进度
echo "Install npm global packages"
npm install -g jshint gulp grunt bower
echo "==========Completed !=========="


echo "✔ Installation done !"