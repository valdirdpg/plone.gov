class plone {

    # XXX: Plone 4.3.15 doesn't have a buildout-cache.tar.bz2
    $plone_version = "4.3.14"

    file { ['/home/root/tmp',
            '/home/root/.buildout',
            '/home/root/buildout-cache',
            '/home/root/buildout-cache/eggs',
            '/home/root/buildout-cache/downloads',
            '/home/root/buildout-cache/extends',
            ]:
        ensure => directory,
        owner => 'root',
        group => 'root',
        mode => '0755',
    }

    file { '/home/root/.buildout/default.cfg':
        ensure => present,
        content => inline_template('[buildout]
eggs-directory = /home/root/buildout-cache/eggs
download-cache = /home/root/buildout-cache/downloads
extends-cache = /home/root/buildout-cache/extends'),
        owner => 'root',
        group => 'root',
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
        creates => '/home/root/py27',
        user => 'root',
        cwd => '/home/root',
        before => Exec['install_buildout_setuptools'],
        timeout => 300,
    }

    # install zc.buildout, setuptools
    exec {'/home/root/py27/bin/pip install -U zc.buildout==2.9.6 setuptools==36.6.1':
        alias => 'install_buildout_setuptools',
        creates => '/home/root/py27/bin/buildout',
        user => 'root',
        cwd => '/home/root',
        before => Exec['clone_repo'],
        timeout => 0,
    }

    # download the buildout-cache from dist.plone.org
    exec {"wget --no-verbose http://dist.plone.org/release/${plone_version}/buildout-cache.tar.bz2":
        alias => 'download_buildout_cache',
        creates => '/home/root/buildout-cache.tar.bz2',
        cwd => '/home/root',
        user => 'root',
        group => 'root',
        before => Exec['unpack_buildout_cache'],
        timeout => 600,
    }

    # unpack the buildout-cache to /home/root/buildout-cache/
    exec {'tar xjf /home/root/buildout-cache.tar.bz2':
        alias => 'unpack_buildout_cache',
        creates => '/home/root/buildout-cache/eggs/Products.CMFPlone-${plone_version}-py2.7.egg/',
        user => 'root',
        cwd => '/home/root',
        before => Exec['clone_repo'],
        timeout => 0,
    }

    # clone IDG repository
    exec {'git clone https://github.com/plonegovbr/portal.buildout.git buildout':
        alias => 'clone_repo',
        creates => '/vagrant/buildout',
        user => 'root',
        cwd => '/vagrant',
        before => Exec['set_default_conf'],
        timeout => 0,
    }

    # set buildout default configuration
    exec {'ln -s travis-development.cfg buildout.cfg':
        alias => 'set_default_conf',
        creates => '/vagrant/buildout/buildout.cfg',
        user => 'root',
        cwd => '/vagrant/buildout',
        before => Exec['buildout'],
        timeout => 0,
    }

    # run IDG buildout
    exec {'/home/root/py27/bin/buildout':
        alias => 'buildout',
        creates => '/vagrant/buildout/bin/instance',
        user => 'root',
        cwd => '/vagrant/buildout',
        # before => Exec['final'],
        timeout => 0,
    }

}

include plone
