Se houver erro ap�s cria��o da m�quina virtual:
1- criar o diret�rio root dentro de /home/ , ficando assim /home/root/
2- Se n�o for ciado o arquivo tempor�rio plone.pp: rodar o comando sudo nano  /tmp/vagrant-puppet/manifests-a11d1078b1b1f2e3bdea27312f6ba513/plone.pp, depois copiar o conteudo que est� em no diret�rio manifest dentro da raiz do git e fazer o mesmo para packages.pp