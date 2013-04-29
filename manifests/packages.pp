class packages {

  $base_reqs = [ "screen", "sudo", "build-essential", "git-core", "vim"]
  package { $base_reqs: ensure => "installed" }

  $base_libs = ["libxml2-dev", "libxslt-dev", "libjpeg-dev", "libfreetype6-dev" ]
  package { $base_libs: ensure => "installed" }

  $python = [ "python-dev", "python-virtualenv" ]
  package { $python: ensure => "installed" }

  # used for creating a PuTTy-compatible key file
  package { "putty-tools":
    ensure => present,
  }

}

include packages
