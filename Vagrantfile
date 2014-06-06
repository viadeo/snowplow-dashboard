# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-7.4-64-ruby"
  config.vm.box_url = "https://s3-us-west-1.amazonaws.com/viadeo-public-vagrant-box/debian-7.4-64-ruby.box"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
  end

end