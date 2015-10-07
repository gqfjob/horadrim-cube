# LNMP@Vagrant 自动化部署脚本

这是一个在 Vagrant 环境下自动部署 lnmp 开发环境的脚本库。

1. 导入 [Dependencies](#Dependencies) 列出的 box，并且 `vagrant up`，不清楚请先阅读 vagrant 手册
1. `vagrant ssh` 登陆虚拟机
1. `git clone git@github.com:linkdesu/lnmp-vagrant.git` 获取本项目源码
1. `cd lnmp-vagrant` 进入项目目录
1. `git submodule init` 获取本项目子模块源码
1. 从 [PHP官方网站]() 下载 `.tar.gz` 格式的 PHP 源码包，并放置到 roles/php/files 目录下
1. 修改 roles/php/defaults>main.yml 中 php_version, php_tarball 与下载的源码保持一致
1. `sudo su root` 切换到 root 账户
1. `./init.sh` 执行 init.sh 脚本

## Main packages List

本部署会自动的安装以下组件。

### PHP
### Nginx
### MariaDB


## Dependencies

为了使用本自动化构建流程，你需要准备以下环境。

* [Vagrant](http://www.vagrantup.com/) >= 1.7.0
* [Box puphpet/centos65-x64](https://atlas.hashicorp.com/puphpet/boxes/centos65-x64) >= 2.0 (非必须，但是没有在其他 box 上进行测试)


## Requirements

简单的使用本部署脚本要求你具备 Vagrant, Shell 相关的基本知识。
配置部署脚本中各个组件相关的配置文件需要你具备组件相对应的知识，比如 php, nginx, mariadb 。
自定义整个部署脚本需要你在具备以上所有知识的同时，掌握 Ansible 相关知识。


## Attention

1. 本脚本多次执行的情况下是 **幂等** 的，所以遇到错误无需惊慌，重新来过即可
