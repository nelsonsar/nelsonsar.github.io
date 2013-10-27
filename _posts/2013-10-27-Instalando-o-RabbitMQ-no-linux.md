---
layout: default
title: "Instalando o RabbitMQ no Linux"
---

Instalar o RabbitMQ no Linux é uma tarefa simples. Você pode usar o seu gerenciador de pacotes e simplesmente procurar pelo pacote do RabbitMQ e instalar como você faz normalmente com outros pacotes. Os dois problemas principais que vejo fazendo isso são:

* A versão do Erlang com certeza não será a mais recente;
* A versão do próprio RabbitMQ não será a mais recente;

E por que você deveria instalar pacotes recentes? Um dos motivos, que eu enxergo, é porque eles contém melhorias e *bug fixes* que você pode tirar proveito. Se por alguma limitação de compatibilidade ou restrição de ambiente você não puder usar pacotes mais recentes, opte por instalar os que vem inclusos na sua distribuição favorita do Linux.

Se você quer usar as versões da sua distribuição este post acaba aqui, caso contrário abaixo descrevo como instalar o RabbitMQ com pacotes mais recentes.

**Importante: Esse post foi escrito quando as versões mais recentes do RabbitMQ e do Erlang eram, respectivamente, 3.2.0 e R16B02.**

## Instalando a versão mais recente do Erlang ##

Você pode baixar a versão mais recente do Erlang na seção [downloads](http://www.erlang.org/download.html) do site do próprio [Erlang](http://www.erlang.com). No site da [Erlang solutions](https://www.erlang-solutions.com/downloads/download-erlang-otp) existem pacotes pra sua distribuição favorita com a versão mais recente e também um *tarball* do source que é o que vamos usar para fazer a instalação.

É importante levar em consideração suas necessidades. Se você vai instalar o RabbitMQ apenas na sua máquina **EU** não vejo necessidade de usar o source pra instalar o Erlang. Use o pacote da sua distribuição e seja feliz! Usar o *tarball* é apenas para aqueles que querem ter controle total do que está sendo instalado (gerenciar dependências de perto) e também pela vantagem de conseguir mudar as diretrizes de configuração, como por exemplo, o local de instalação, etc.

1. Baixando o *tarball*:

   Use sua ferramenta favorita para fazer o download. Eu usei o ```curl``` e rodei o seguinte comando:

   ```cd /tmp && curl https://packages.erlang-solutions.com/erlang/esl-erlang-src/otp_src_R16B02.tar.gz | tar -zxf -```

2. Instalando dependências do Erlang:

   As dependências do Erlang estão listadas em HOWTO/INSTALL.md para a nossa instalação usaremos as seguintes:

   * make;
   * gcc;
   * m4;
   * ncurses, termcap ou termlib;

   Se você planeja usar SSL com o RabbitMQ você deve instalar também o ```openssl``` e ```libssl-dev```.

3. Finalmente instalando o Erlang:

   Na pasta que você descompactou o *tarball* você vai rodar os seguintes comandos:

   ```./configure --enable-hipe && make && make install```

   Você pode mudar o local que deseja o Erlang seja compilado passando no ```./configure``` a opção ```--prefix=caminhoquedesejacompilar``` e se você optou por instalar o ```openssl``` você deve passar a opção ```--with-ssl```.

   **Lembre-se: os comandos executados podem exigir permissão de administrador**

E, pronto! O Erlang está instalado!

Se você digitar ```erl``` na sua linha de comando o shell client do Erlang e na primeira linha já poderemos ver que o ```HiPE``` foi instalado. Para sair do shell use ```^C``` + a + Enter. 

## Instalando o RabbitMQ ##

A instalação do RabbitMQ é muito mais tranquila que a do Erlang. Para começar vamos fazer o *download* do *tarball* [aqui](http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.0/rabbitmq-server-generic-unix-3.2.0.tar.gz) (você pode usar o mesmo processo usado para fazer o *download* do Erlang).

Eu tenho o costume de colocar pacotes adicionais no diretório ```/opt``` (o motivo para isso está escrito [aqui](http://www.linuxtopia.org/online_books/linux_beginner_books/linux_filesystem/opt.html)) e, então para criar a estrutura de diretório:

 ```mkdir /opt/rabbitmq && tar --strip=1 -zxf rabbitmq-server-generic-unix-3.2.0.tar.gz -C /opt/rabbitmq```

O comando acima criará a pasta ```rabbitmq``` dentro da pasta ```/opt``` e extrairá o conteúdo do *tarball* ```rabbitmq-server-generic-unix-3.2.0.tar.gz``` sem o primeiro nível (```rabbitmq_server-3.2.0```) na recém criada ```/opt/rabbitmq```.

**Sempre importante lembrar: os comandos podem exigir permissões de admnistrador.**

Para garantir uma inicialização tranquila do servidor crie de antemão as pastas de **log** e do **[mnesia](http://www.erlang.org/doc/man/mnesia.html)**.

```mkdir -p /var/log/rabbitmq```

É o mesmo caso para a pasta do mnesia:

```mkdir -p /var/lib/rabbitmq/mnesia/rabbit```

As duas pastas criadas acima podem ser criadas no mesmo diretório que você extraiu o *tarball* como pode ser visto [aqui](http://www.rabbitmq.com/relocate.html).

Feito isso, você pode iniciar o servidor do RabbitMQ usando ```sbin/rabbitmq-server``` ou ```sbin/rabbitmq-server -detached``` se você quiser que o servidor inicia em *background*. Se você não iniciou o servidor em *background* você deve ver algo semelhante a isso:

![rabbitmq-server iniciado](http://i.imgur.com/ttXQCDP.png?1)

## Dicas ##

Dica 1: use o ```chown``` para mudar o dono da pasta ```/opt/rabbitmq```, caso seja necessário, dessa forma você evita o uso do ```sudo``` o tempo inteiro sem a menor necessidade.

Dica 2: faça [links simbólicos](http://www.cyberciti.biz/tips/understanding-unixlinux-symbolic-soft-and-hard-links.html) dos binários encontrados na pasta ```sbin``` para a pasta ```/usr/local/sbin``` ou ```/usr/local/sbin```, assim você pode usar os binários em qualquer lugar do sistema operacional (não vai precisar ficar digitando o caminho absoluto ou relativo dos binários).

## Considerações finais ##

Tentei fazer o tutorial mais genérico possível e que cobrisse a maior parte de distribuições também. A parte que talvez possa lhe trazer problema é a instalação do Erlang por causa das dependências e, por isso aconselho você usar uma VM para fazer o teste, dessa forma você pode testar quantas vezes lhe for necessário.

Tudo que disse aqui foi testado na VM default do [Vagrant](http://www.vagrantup.com/) e tudo correu perfeitamente bem.

Qualquer dúvida, lamentação ou comentário, por favor, não exite em me contactar no [twitter](https://twitter.com/nelsonsar).

Até a próxima! ☮
