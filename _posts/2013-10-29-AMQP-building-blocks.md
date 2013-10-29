---
layout: default
title: "AMQP Building blocks"
---
O protocolo [AMQP](http://rubydoc.info/github/ruby-amqp/amqp/master/file/docs/AMQP091ModelExplained.textile) visa padronizar a interação entre clientes e o *middleware* de "mensageria" os famosos *brokers*. Para entender como o protocolo funciona é necessário conhecer seus componentes e como se dá a integração entre eles.

<img alt="componentes" src="http://www.rabbitmq.com/img/tutorials/intro/hello-world-example-routing.png" class="centered-image" />
<div class="image-caption">Créditos da imagem para <a href="http://www.gopivotal.com/">GoPivotal</a></div>

O *middleware* de mensagem  pode ser definido como um servidor de dados que recebe mensagens e faz basicamente duas coisas com elas: as encaminha para diferentes *consumers* dependendo da política de rotas ou as armazena, em memória ou disco, quando os *consumers* não são capazes de aceitá-las imediatamente.  

Uma das vantagens entre soluções que implemetam o protocolo AMQP e as que não implementam o protocolo são os componentes. Os componentes criados pelo protocolo são modulares e tem responsabilidades bem definidas, por exemplo:

* Exchange: tem como tarefa de receber as mensagens do *producer* e encaminhar as mensagens para filas;
* Queues: Armazenam as mensagens e encaminham elas para os *consumers*;

Componentes com responsabilidades bem definidas implicam em reutilização, por exemplo, é possível usar uma mesma exchange para abastecer diferentes filas (*queues*) que, podem abastecer diferentes *consumers* e produzir resultados diferentes. Esta característica aliada a capacidade do protocolo de criar *exchanges*, filas (*queues*) de mensagem e associa-las em tempo de execução torna possível construir qualquer sistema baseado em mensagens.

Abaixo apresento a fundo os componentes do protocolo.

## Componentes ##

Apesar de não serem componentes do protocolo em si, *consumers* e *producers*, serão citados diversas vezes, portanto, nada mais justo do que descrevê-los:

**Consumer**: Aplicações responsáveis por consumir, como o nome diz, as filas de mensagem (*queues*).

**Producer**: Aplicações responsáveis por publicar mensagens nos *exchanges*.

Abaixo, finalmente os componentes do protocolo AMQP.

### Message queue (A fila de mensagem) ###

Objeto responsável por armazenar as mensagens em memória ou em disco e, entrega estas em sequência para os *consumers*. As filas são inteiramente independentes umas das outras e seu comportamento pode ser definido por algumas propriedades, algumas delas são:

* Privada ou compartilhada (*private* ou *shared*): Filas privadas são aquelas que respondem a apenas um *consumer*, o oposto das compartilhadas que respondem a vários *consumers* de acordo com o algoritmo [round robin](http://pt.wikipedia.org/wiki/Round-robin).

* Durável ou temporária (*durable* ou *temporary*): Filas duráveis são aquelas que guardarão as mensagens que também forem publicadas como duráveis. Desta forma se o servidor for reiniciado ou desligado o estado da fila será mantido. As filas temporárias são o oposto. Elas não serão recriadas caso o servidor seja reiniciado ou desligado. 

* Nomeada pelo cliente ou nomeada pelo servidor (*client-named* ou *server-named*): As filas podem ser nomeadas pelo servidor, ou seja, o servidor fica responsável por designar um nome para a fila. No caso oposto cliente pode dar um nome para a fila que deseja consumir.

### Exchange ###

O *exchange* é o objeto que aceita a mensagem de um *producer* e a encaminha para as filas de acordo com um critério pré-definido. Esse critério é chamado de *binding*. O exchange é basicamente um sistema de rotas, que inspeciona a mensagem e usando sua tabela de critérios decide como a encaminhar as mensagens, seja para uma fila de mensagem ou para outro exchange.

Exchanges possuem tipos definidos pelo protocolo AMQP (*direct* e *topic*, por exemplo) que também provê instâncias padrão dos tipos definidos. Este objeto existe para que seja possível estender a funcionalidade padrão do protocolo, portanto, aplicações que o usam podem criar suas próprias instâncias nomeadas, ou seja, criar seu próprio mecanismo de rota.

De maneira geral para fazer o roteamento das mensagens o exchange examina as propriedades da mensagem, cabeçalho e conteúdo, e possivelmente de outras fontes. Na maioria dos casos o exchange examina um único campo, que é chamado de **routing key**. Este campo nada mais é do que um endereço virtual que o exchange pode usar para encaminhar a mensagem.

### Bindings ###

Assim como *consumer* e *producer*, o *binding* não é bem um componente, mas, dada sua importância o inclui aqui. O relacionamento entre as filas de mensagem e os *exchanges* tem o nome de *binding*. Este relacionamento indica ao exchange como ele deve encaminhar as mensagens. O responsável por criar esse relacionamento é o *consumer*, na maioria dos casos, ou o "dono", que pode ser o *producer*,  da fila.

### Channel (ou canal) ###

A conexão da aplicação cliente com o *broker* é feita através do protocolo TCP. As conexões usam autenticação e podem usar conexões SSL. Conexões via TCP custam caro para o sistema operacional e, por isso, os canais existem. Os canais, dentro do protocolo AMQP, são "conexões leves que compartilham a mesma conexão TCP", ou seja, é necessária apenas uma instância de conexão para executar múltiplas ações (em aplicações que usam threads é possível abrir um canal por thread) e, isso também é possível porque a comunicação é completamente independente de um canal para o outro.

### Virtual hosts ###

Para ser possível utilizar o mesmo *broker* para múltiplas aplicações e/ou ambientes (*exchanges*, *queues*, etc), o protocolo AMQP inclui o conceito de *virtual hosts*. O comportamento é semelhante aos de um servidor web, como o Apache. O cliente decide qual virtual host será utilizado no momento da conexão.

## Observações importantes ##

Este post é uma apresentação do protocolo AMQP. Ainda é preciso definir como as mensagens são produzidas, consumidas e como é o seu ciclo de vida. Vale também lembrar que não foram explorados os tipos de exchange e seus casos de uso, o mesmo vale para as filas de mensagem.

Vou abordar estes assuntos em outro post pelo fato de acreditar que é necessário entender **bem** cada componente que foi descrito aqui.

## Fontes ##

Você não precisa acreditar em mim e muito menos esperar eu fazer outro post sobre o AMQP. Na [documentação](http://www.rabbitmq.com/tutorials/amqp-concepts.html) do RabbitMQ existe uma página dedicada ao protocolo e retirei as definições de *virtual hosts* e canais de lá, portanto, sinta-se à vontade para ler e criticar este que vos escreve.
