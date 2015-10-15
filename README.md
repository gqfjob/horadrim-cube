# LNMP@Vagrant 自动化部署脚本

这是一个在 Vagrant 环境下自动部署 lnmp 开发环境的脚本库。


## Features

* 除了 Yum 可以直接下载的资源，其他所有较大的资源都是必须提前下载好使用的，可以不受**墙**的影响，用最爱的下载工具下好就行
* 配置 Vagrant, Nginx, PHP, MariaDB 不需要额外的知识，只需要把配置文件放到指定目录即可
* PHP 的编译参数可调，需要部分 YAML 知识


## Dependencies

为了使用本自动化构建流程，你需要准备以下环境。

* [Vagrant](http://www.vagrantup.com/) >= 1.7.0
* [puphpet/centos65-x64](https://atlas.hashicorp.com/puphpet/boxes/centos65-x64) box >= 2.0 (非必须，但是没有在其他 box 上进行测试)


## Requirements

简单的使用本部署脚本要求你具备 Vagrant, Shell 相关的基本知识。
配置部署脚本中各个组件相关的配置文件需要你具备组件相对应的知识，比如 php, nginx, mariadb 。
自定义整个部署脚本需要你在具备以上所有知识的同时，掌握 Ansible 相关知识。


## Installation

第一步，准备 vagrant box，并获取本项目源码:

1. 提前下载好 puphpet/centos65-x64 box ，并导入 vagrant
1. `git clone git@github.com:linkdesu/lnmp-vagrant.git` 获取本项目源码
1. 将本项目源码移动到你想要用来创建 vagrant 项目的目录，以下简称 `/path/to/project`
1. `cd /path/to/project` 进入项目目录
1. `git submodule init` 获取本项目子模块源码
1. `vagrant up` 启动虚拟机
1. `vagrant ssh` 登陆虚拟机

第二步，下载各种需要下载的大块头资源，然后执行脚本:

1. 从 [kernel.org](https://www.kernel.org/pub/software/scm/git/) 下载 `.tar.xz` 格式的 Git 源码包，并放置到 roles/common/files 目录下
1. 如果你下载的是 git-2.5.0.tar.gz 那么可以直接使用。如果不是，请修改 roles/common/defaults>main.yml 中 git_version, git_tarball 与下载的源码保持一致
1. 从 [PHP官网](https://secure.php.net/downloads.php) 下载 `.tar.gz` 格式的 PHP 源码包，并放置到 roles/php/files 目录下
1. 如果你下载的是 php-5.6.14.tar.gz 那么可以直接使用。如果不是，请修改 roles/php/defaults>main.yml 中 php_version, php_tarball 与下载的源码保持一致
1. `sudo su root` 切换到 root 账户
1. `cd /vagrant; ./install.sh` 执行 install.sh 脚本

最后，如果看到以下内容，那么恭喜你，安装成功了！
如果你没有修改 Vagrantfile ，那么访问 http://192.168.44.101/info.php 应该就能够看到 `phpinfo()` 的输出信息了。

```shell
Writing lock file
Generating autoload files
==========Completed !==========
Install npm global packages
./install.sh: line 53: npm: command not found
==========Completed !==========
✔ Installation done !
```


## Main packages List

本部署会自动的安装以下组件。

### Git
### PHP
### Nginx
### MariaDB(MySQL)
### Nodejs


## Attention

1. 本脚本多次执行的情况下是 **幂等** 的，所以遇到错误无需惊慌，重新来过即可
1. 复杂的编译步骤会根据某些条件在确定可执行文件存在的情况下，略过执行，所以如果你想重新编译，请删除可执行文件
1. 偶尔 Yum 也会有下载超时的情况，可以在 install.yml 中注释掉已执行的步骤后重新执行
