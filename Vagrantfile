# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puphpet/centos65-x64"
  config.vm.box_check_update = false
  config.vm.hostname = "vagrant-develop"

  # ssh 配置
  config.ssh.forward_agent
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  # 网络配置，默认使用私有网络
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.44.101"
  # config.vm.network "public_network"

  # 同步目录配置
  config.vm.synced_folder "www", "/usr/local/www"

  # 需要调试配置时可以取消下面注释
  #config.vm.provider "virtualbox" do |vb|
  #  vb.gui = true
  #  vb.memory = "1024"
  #end

  # 系统启动、同步目录挂载完成后才启动 nginx, php-fpm, mysql
  $script = <<-SHELL
    echo "$(hostname) is online ! ✔"
  SHELL
  config.vm.provision "shell", run: "always", inline: $script
end
