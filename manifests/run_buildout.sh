#!/bin/sh
AS_VAGRANT="sudo -u vagrant"
SHARED_DIR="/vagrant"
#BUILDOUT_FILE="development.cfg"
BUILDOUT_FILE="staging.cfg"

cd $SHARED_DIR
# RUBY_PLATFORM=$1
if [ ! -d portalmodelo_buildout ]; then
    echo "No repo, nothing to see here"
else
    cd portalmodelo_buildout
    if [ ! -d env ]; then
    	echo "Prepare virtualenv"
    	$AS_VAGRANT virtualenv env
    	echo "Install distribute"
    	$AS_VAGRANT env/bin/easy_install -U distribute
    	echo "Execute bootstrap"
    	$AS_VAGRANT env/bin/python bootstrap.py -c $BUILDOUT_FILE
	    echo "Run buildout"
    	$AS_VAGRANT ./bin/buildout -c $BUILDOUT_FILE
    else
    	$AS_VAGRANT ./bin/develop rb
    fi
    cd ~/
fi