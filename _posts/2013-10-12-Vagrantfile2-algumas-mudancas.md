---
layout: default
title: "Vagrantfile2: Algumas mudanças"
---
Essa é a versão 1 do *Vagrantfile*:

<pre class="language-ruby"><code>
Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.host_name = "blog"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.share_folder("blog", "/var/www/blog", "..", :extra => 'dmode=777,fmode=777')
  config.vm.forward_port 80, 8099
  config.vm.forward_port 443, 44399

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "blog.pp"
    puppet.module_path = "modules"
  end

end
</code></pre>

E essa é a versão 2:

<pre class="language-ruby"><code>
Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.host_name = "blog"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.synced_folder("..", "/var/www/blog", :mount_options => ['dmode=777','fmode=777'])
  config.vm.network "forwarded_port", guest: 80, host: 8099
  config.vm.network "forwarded_port", guest: 443, host: 44399

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "blog.pp"
    puppet.module_path = "modules"
  end

end
</code></pre>

Notem que os dois arquivos são **bem** simples e, não a quase nenhuma customização. Mas, vamos ao que interessa: as mudanças!

* A primeira mudança vem logo na primeira linha dos arquivos: <span class="inline-code language-c-like"><pre><code>Vagrant::Config.run do |config|</code></pre></span> vira <span class="inline-code"><pre><code>Vagrant.configure("2") do |config|</code></pre></span> onde, o número *2* significa a versão do *Vagrantfile* que você quer usar. Estão disponíveis as versões *1* e *2*. Algumas configurações podem ser mantidas se a versão informada for a *1*. Nesses arquivos, por exemplo, basta substituir o  <span class="inline-code"><pre><code>extra</code></pre></span> por <span class="inline-code"><pre><code>mount_options</code></pre></span> e passar os parâmetros através de um <span class="inline-code"><pre><code>array</code></pre></span> ao invés de uma <span class="inline-code"><pre><code>string</code></pre></span> separada por vírgulas;
* A diretiva <span class="inline-code"><pre><code>config.vm.share_folder</code></pre></span> dá lugar à <span class="inline-code"><pre><code>config.vm.synced_folder</code></pre></span>. Notem que o número de parâmetros é menor na versão *2* e que também a ordem é invertida. O primeiro parâmetro é a pasta no **host** e o segundo parâmetro é o caminho na máquina virtual (se a pasta não existir será criada e, recursivamente se necessário). A diretiva <span class="inline-code"><pre><code>:extra</code></pre></span> dá lugar à <span class="inline-code"><pre><code>:mount_options</code></pre></span>, como dito no primeiro item;
* A última mudança notável é a nova maneira de declarar *forwarded ports*. A diretiva <span class="inline-code"><pre><code>config.vm.forward_port</code></pre></span> dá lugar à <span class="inline-code"><pre><code>config.vm.network</code></pre></span> e *port forwarding* torna-se um parâmetro da mesmo. Tornando-se muito mais intelegível, na minha opinião.

As mudanças não param nesses pequenos detalhes, claro. Mas, com essas pequenas alterações é possível manter-se atualizado com as novas versões do Vagrantfile.

Eu mantenho um esqueleto do vagrant [nesse repositório](https://github.com/nelsonsar/vagrant-skeleton) e uso ele em alguns projetos pra facilitar a vida.
