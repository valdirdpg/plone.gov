=============================
Configuração Vagrant para IDG
=============================

.. contents:: Conteúdo
   :depth: 2

Introdução
==========

`Vagrant <https://www.vagrantup.com/>`_ é uma ferramenta para construir e gerenciar ambientes de máquinas virtuais em um workflow simples.
Vagrant se encontra disponível para sistemas operacionais Debian/Ubuntu, Windows, Centos e Mac OS X.

Este repositório contem uma configuração Vagrant para desenvolvimento do modelo de portal Plone para Identidade Digital de Governo.

Preparação do ambiente
======================

Instalação do VirtualBox
------------------------

Vagrant usa VirtualBox para criar ambientes virtuais.

No Ubuntu 16.04 LTS:

.. code-block:: console

    $ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    $ echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    $ sudo apt update
    $ sudo apt install dkms virtualbox-5.2

.. note::
    Informação sobre como instalar Vagrant em outros sistemas operacionais pode ser encontrada em `Download VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_.

Instalação do Vagrant
---------------------

A versão mais recente pode ser descargada diretamente em `Download Vagrant <https://www.vagrantup.com/downloads.html>`_.

Após a instalação um novo comando ``vagrant`` estará disponível no seu computador:

.. code-block:: console
    $ vagrant -v
    Vagrant 2.0.1

Opcionalmente pode ser instalado um plugin que ajuda manter as `Guest Additions <https://www.virtualbox.org/manual/ch04.html>`_ do VirtualBox atualizadas:

.. code-block:: console

    $ vagrant plugin install vagrant-vbguest

Criação e provisionamento da máquina virtual
============================================

Clone este repositório na pasta onde irá trabalhar:

.. code-block:: console

    $ git clone https://github.com/plonegovbr/portal.vagrant.git idg
    $ cd idg

Na sequência você precisar criar e provisionar sua máquina virtual:

.. code-block:: console

    $ vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Importing base box 'ubuntu/xenial64'...
    ...
    ==> default: Notice: Finished catalog run in 675.01 seconds

.. warning::
    O processo de criação e provisão da máquina virtual pode demorar muito tempo,
    dependendo da velocidade de sua conexão à internet e de outros recursos do sistema.
    Seja paciente.

Se por acaso a provisão da máquina virtual falhou, pode reiniciar o proceso usando:

.. code-block:: console

    $ vagrant provision
    ==> default: Running provisioner: shell...
    ...
    ==> default: Notice: Finished catalog run in 13.14 seconds

Acessando a máquina virtual
===========================

Acesse a máquina virtual usando o seguinte comando:

.. code-block:: console

    $ vagrant ssh
    Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-98-generic x86_64)
    ...
    Last login: Fri Nov 10 18:20:57 2017 from 10.0.2.2

Iniciando o IDG
===============

Para iniciar o IDG só precisa fazer o seguinte:

.. code-block:: console

    ubuntu@idg:~$ cd /vagrant/buildout/
    ubuntu@idg:/vagrant/buildout$ bin/instance fg
    2017-11-10 16:25:39 INFO ZServer HTTP server started at Fri Nov 10 16:25:39 2017
        Hostname: 0.0.0.0
        Port: 8080
    ...
    2017-11-10 16:26:24 INFO Zope Ready to handle requests

Abre uma janela em su web browser e aponte a ``localhost:8080``.

.. figure:: https://raw.githubusercontent.com/plonegovbr/portal.vagrant/master/up-and-running.png
    :align: center
    :height: 768px
    :width: 1024px

O Plone está disponível e pronto para criação de sites IDG.

Para parar o servidor Zope presione ``Ctrl+C``:

.. code-block:: console

    ...
    2017-11-10 16:32:17 INFO SignalHandler Caught signal SIGINT
    2017-11-10 16:32:17 INFO Z2 Shutting down

Para sair da máquina virtual presione ``Ctrl+D`` ou utilice o comando ``logout``.

.. code-block:: console

    ubuntu@idg:~$ logout
    Connection to 127.0.0.1 closed.

Destruíndo a máquina virtual
============================

Quando não precisar mais o ambiente de desenvolvimento do IDG pode destruir a máquina virtual usando o seguinte comando:

.. code-block:: console

    $ vagrant destroy
        default: Are you sure you want to destroy the 'default' VM? [y/N] y
    ==> default: Forcing shutdown of VM...
    ==> default: Destroying VM and associated drives...
