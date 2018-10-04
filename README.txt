Se houver erro após criação da máquina virtual:
1- criar o diretório root dentro de /home/ , ficando assim /home/root/
2- Se não for ciado o arquivo temporário plone.pp: rodar o comando sudo nano  /tmp/vagrant-puppet/manifests-a11d1078b1b1f2e3bdea27312f6ba513/plone.pp, depois copiar o conteudo que está em no diretório manifest dentro da raiz do git e fazer o mesmo para packages.pp