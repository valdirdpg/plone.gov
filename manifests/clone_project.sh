#!/bin/sh

AS_VAGRANT="sudo -u vagrant"
SHARED_DIR="/vagrant"

# RUBY_PLATFORM=$1
cd $SHARED_DIR
if [ ! -d portalmodelo_buildout ]; then
    if [ ! -d .ssh ]; then
        $AS_VAGRANT mkdir -p /home/vagrant/.ssh
    fi
    echo "Clone the repo"
    $AS_VAGRANT echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/vagrant/.ssh/config
    $AS_VAGRANT git clone git@github.com:plonegovbr/portalmodelo.buildout.git
else
    echo "Repo already there"
fi