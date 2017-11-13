class plone {

    # XXX: Plone 4.3.15 doesn't have a buildout-cache.tar.bz2
    $plone_version = "4.3.14"

    file { ['/home/ubuntu/tmp',
            '/home/ubuntu/.buildout',
            '/home/ubuntu/buildout-cache',
            '/home/ubuntu/buildout-cache/eggs',
            '/home/ubuntu/buildout-cache/downloads',
            '/home/ubuntu/buildout-cache/extends',
            ]:
        ensure => directory,
        owner => 'ubuntu',
        group => 'ubuntu',
        mode => '0755',
    }

    file { '/home/ubuntu/.buildout/default.cfg':
        ensure => present,
        content => inline_template('[buildout]
eggs-directory = /home/ubuntu/buildout-cache/eggs
download-cache = /home/ubuntu/buildout-cache/downloads
extends-cache = /home/ubuntu/buildout-cache/extends'),
        owner => 'ubuntu',
        group => 'ubuntu',
        mode => '0664',
    }

    Exec {
        path => [
           '/usr/local/bin',
           '/opt/local/bin',
           '/usr/bin',
           '/usr/sbin',
           '/bin',
           '/sbin'],
        logoutput => true,
    }

    # create virtualenv
    exec {'virtualenv py27':
        alias => 'virtualenv',
        creates => '/home/ubuntu/py27',
        user => 'ubuntu',
        cwd => '/home/ubuntu',
        before => Exec['install_buildout_setuptools'],
        timeout => 300,
    }

    # install zc.buildout, setuptools
    exec {'/home/ubuntu/py27/bin/pip install -U zc.buildout==2.9.5 setuptools==36.3.0':
        alias => 'install_buildout_setuptools',
        creates => '/home/ubuntu/py27/bin/buildout',
        user => 'ubuntu',
        cwd => '/home/ubuntu',
        before => Exec['clone_repo'],
        timeout => 0,
    }

    # download the buildout-cache from dist.plone.org
    exec {"wget --no-verbose http://dist.plone.org/release/${plone_version}/buildout-cache.tar.bz2":
        alias => 'download_buildout_cache',
        creates => '/home/ubuntu/buildout-cache.tar.bz2',
        cwd => '/home/ubuntu',
        user => 'ubuntu',
        group => 'ubuntu',
        before => Exec['unpack_buildout_cache'],
        timeout => 600,
    }

    # unpack the buildout-cache to /home/ubuntu/buildout-cache/
    exec {'tar xjf /home/ubuntu/buildout-cache.tar.bz2':
        alias => 'unpack_buildout_cache',
        creates => '/home/ubuntu/buildout-cache/eggs/Products.CMFPlone-${plone_version}-py2.7.egg/',
        user => 'ubuntu',
        cwd => '/home/ubuntu',
        before => Exec['clone_repo'],
        timeout => 0,
    }

    # clone IDG repository
    exec {'git clone https://github.com/plonegovbr/portal.buildout.git buildout':
        alias => 'clone_repo',
        creates => '/vagrant/buildout',
        user => 'ubuntu',
        cwd => '/vagrant',
        before => Exec['set_default_conf'],
        timeout => 0,
    }

    # set buildout default configuration
    exec {'ln -s travis-development.cfg buildout.cfg':
        alias => 'set_default_conf',
        creates => '/vagrant/buildout/buildout.cfg',
        user => 'ubuntu',
        cwd => '/vagrant/buildout',
        before => Exec['buildout'],
        timeout => 0,
    }

    # run IDG buildout
    exec {'/home/ubuntu/py27/bin/buildout':
        alias => 'buildout',
        creates => '/vagrant/buildout/bin/instance',
        user => 'ubuntu',
        cwd => '/vagrant/buildout',
        # before => Exec['final'],
        timeout => 0,
    }

}

include plone
