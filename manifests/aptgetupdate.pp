class aptgetupdate {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    unless => "/usr/bin/test -d portalmodelo_buildout"
  }
}

include aptgetupdate
