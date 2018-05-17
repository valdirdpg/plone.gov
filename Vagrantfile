# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"

  config.vm.hostname = "idg"
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  # allow the creation of symbolic links in the shared folder.
  # this is needed for some builds with cmmi and for omelette to work.
  # 'v-root' is the default-name for the primary volume.
  config.vm.provider :virtualbox do |vb|
    vb.customize  ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize  ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize  ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # a workaround for missing symbolic links on windows:
  # config.vm.synced_folder "eggs/", "/home/vagrant/buildout-cache/eggs/"

  # read initial package index information + upgrade
  config.vm.provision :shell, inline: <<-SHELL
      apt-get update
      apt-get -y upgrade
  SHELL

  # we need to install puppet on the guest before we can use it
  config.vm.provision :shell, inline: <<-SHELL
      apt-get install -y puppet
  SHELL

  # install operating System dependencies
  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "packages.pp"
  end

  # create a Putty-style keyfile for Windows users
  # FIXME: fails with: "default: /tmp/vagrant-shell: 43: [: /vagrant/README.rst: unexpected operator"
  # config.vm.provision :shell do |shell|
  #     shell.path = "manifests/host_setup.sh"
  #     shell.args = RUBY_PLATFORM
  # end

  # install IDG
  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "plone.pp"
  end

end
