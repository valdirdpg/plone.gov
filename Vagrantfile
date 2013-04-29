# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "portalmodelo"
  config.vm.hostname = "portalmodelo"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.ssh.forward_agent = true
  # config.vm.boot_mode = :gui
  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged
  config.vm.network :forwarded_port, host: 8080, guest: 8080
  config.vm.provision :shell do |shell|
      shell.path = "manifests/sshagent.sh"
      shell.args = RUBY_PLATFORM
  end

  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "aptgetupdate.pp"
  end

  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "packages.pp"
  end

  config.vm.provision :shell do |shell|
      shell.path = "manifests/clone_project.sh"
      shell.args = RUBY_PLATFORM
  end

  config.vm.provision :shell do |shell|
      shell.path = "manifests/run_buildout.sh"
      shell.args = RUBY_PLATFORM
  end

end
