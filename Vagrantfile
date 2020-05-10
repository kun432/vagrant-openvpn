# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder "./share", "/share" , type: "virtualbox"
  config.vm.define "gw-a" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "gw.a.private"
      c.vm.network "private_network", ip: "10.0.0.10"
      c.vm.network "private_network", ip: "192.168.0.10"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 512
      end
      c.vm.provision :shell, :path => "setup-initial.sh"
      c.vm.provision :shell, :path => "setup-router.sh"
  end

  config.vm.define "gw-b" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "gw.b.private"
      c.vm.network "private_network", ip: "10.0.0.20"
      c.vm.network "private_network", ip: "192.168.100.10"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 512
      end
      c.vm.provision :shell, :path => "setup-initial.sh"
      c.vm.provision :shell, :path => "setup-router.sh"
  end

  config.vm.define "server" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "vpn-server.b.private"
      c.vm.network "private_network", ip: "192.168.100.20"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 512
      end
      c.vm.provision :shell, :path => "setup-initial.sh"
      c.vm.provision :shell, :path => "setup-openvpn.sh"
      c.vm.provision :shell, :path => "setup-host.sh"
  end
  
  config.vm.define "web-server" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "web-server.b.private"
      c.vm.network "private_network", ip: "192.168.100.30"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 512
      end
      c.vm.provision :shell, :path => "setup-initial.sh"
      c.vm.provision :shell, :path => "setup-host.sh"
      c.vm.provision :shell, :path => "setup-web.sh"
  end

  config.vm.define "client" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "vpn-client.a.private"
      c.vm.network "private_network", ip: "192.168.0.20"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 512
      end
      c.vm.provision :shell, :path => "setup-initial.sh"
      c.vm.provision :shell, :path => "setup-openvpn.sh"
      c.vm.provision :shell, :path => "setup-host.sh"
  end
end
