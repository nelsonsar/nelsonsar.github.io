---
layout: default
title: "RabbitMQ: Um pouco sobre mensagens"
related: [
    "RabbitMQ: Tipos de exchange",
    "Instalando o RabbitMQ no Linux",
    "AMQP Building blocks"
]
---

Durante a série de posts sobre o RabbitMQ falei dos componentes do protocolo AMQP e dei também uma atenção especial para os tipos de **exchange**, neste post darei atenção para as famosas **mensagens**, mais especificamente, falarei sobre seu ciclo de vida.

## Mensagens: Como são criadas? Como vivem?

A mensagem no protocolo AMQP nasce a partir de uma aplicação do tipo **producer**, que define o conteúdo e as propriedades da mesma. Após o nascimento da mensagem, seu gerador a identifica com as informações da rota que ela deve seguir e a encaminha para o um **exchange** no servidor AMQP.

Assim que a mensagem chega ao servidor ela pode seguir o caminho feliz das mensagens e ser novamente encaminhada, agora pelo **exchange**, para uma ou mais filas. Há também o caminho das mensagens "perdidas", ou seja, ela não pode ser encaminhada para nenhuma fila e seu destino é ser descartada pelo **exchange**, silenciosamente, ou retornar para o seu gerador. A decisão de como serão tratadas as mensagens "perdidas" é tomada por seu gerador.

## Como são tratadas?

Assim que a mensagem chega na fila de destino (caminho feliz), a fila tenta encaminhar a mensagem para uma aplicação do tipo **consumer**. Se não for possível a fila armazena a mensagem, no disco ou em memória, e espera até que o **consumer** esteja pronto para receber mensagens. Se nenhum **consumer** aparecer a fila pode devolver a mensagem para seu gerador.

Mas em um mundo perfeito onde toda fila tem consumers esperando por mensagens, o que acontece com a mensagem? A mensagem entregue ao **consumer** é removida da fila. A remoção da mensagem da fila pode acontecer imediatamente ou depois do **consumer** marcar a mensagem como "reconhecida" (acknowledged) ou rejeitar a mesma (false acknowledgement).

Assim como nos banco de dados uma transação pode ser iniciada antes de produzir a mensagem e da mesma ser reconhecida pelo **consumer** para total garantia que a mensagem seguiu o caminho que era esperado. Também como nos bancos de dados é possível executar o "commit" ou "rollback" para uma transação.

## E como fazer com que durem?

Se o RabbitMQ resolver parar para descansar suas mensagens e filas vão para o limbo. A menos que você diga para ele que você quer que suas filas e mensagens *DUREM*. Para isso é preciso que você declare a fila como durável. Usando a extensão PECL do PHP:

<pre class="language-php"><code>
$queue = new AMQPQueue($channel);
$queue->setFlags(AMQP_DURABLE);
</code></pre>

É importante ressaltar que o RabbitMQ não vai deixar você redefinir uma fila existente com novos parâmetros, ou seja, você não pode mudar uma fila de durável para não durável de uma hora para outra, você vai precisar criar uma nova fila.

Outro ponto importante é que a alteração da propriedade da fila deve ser propagada tanto nas aplicações do tipo **consumer** quanto nas do tipo **producer**.

Agora, vamos ver o que fazer com as mensagens para que elas se tornem persistentes.

Para tornar a mensagem persistente temos que passar o atributo **delivery_mode** como 2.

<pre class="language-php"><code>
$exchange = new AMQPExchange($channel);
$exchange->publish('Hello!', 'routing.key', AMQP_NOPARAM, array('delivery_mode' => 2));
</code></pre>

Assim, tanto a fila quanto a mensagem serão recriadas caso o RabbitMQ parar por algum motivo. Mensagens persistentes tem um grande problema. Elas não são salvas no disco imediatamente, portanto, as garantias não são lá essas coisas. Para garantia *total* do fluxo mensagem é necessário usar **transações**.

## Dica: Transações vão fazer o coelho engasgar

Apesar de serem o único jeito de garantir, totalmente, que as mensagens atingirão seu destino as transações são nocivas para o RabbitMQ. Por que? Transações podem reduzir a performance em até 250 vezes!

Sabendo desse problema, o RabbitMQ possui o sistema de confirmação (confirms ou **publisher acknowledgements**). Esse sistema permite que o **producer** receba a informação de quantas mensagens foram confirmadas pelo **consumer**. O único inconveniente é que será preciso manter a contagem das mensagens, portanto, para saber se uma mensagem foi processada ou não é necessário checar o campo **delivery-tag** para saber quais mensagens devem ser publicadas novamente.

*Nota importante:* Seguindo a lógica de que uma fila não durável não pode tornar-se durável, um canal transacional não pode entrar em modo de confirmação e vice e versa.

*Nota importante:* A extensão da PECL não tem suporte ao confirme mode, apenas à transações. Então, se você precisar do modo de confirmação deve dar uma olhada na [php-amqplib](https://github.com/videlalvaro/php-amqplib).

## Conclusão

Entender o ciclo de vida da mensagem é importante. Ele representa o fluxo que uma aplicação usando o protocolo AMQP segue, portanto, se este post não foi suficiente para que você perceba como será a arquitetura da sua aplicação, LEIA MAIS SOBRE O ASSUNTO! Neste blog há mais informações sobre o protocolo e links para outras fontes de informação.

Esse é um apanhado sobre mensagens e persistência. A idéia aqui foi mostrar que é possível ter mensagens persistentes, mas, que esse não deve ser o caso para toda e qualquer mensagem que você vai publicar/consumir e, mais que isso é necessário *PENSAR* em sua estratégia de publicação/consumo de mensagens.

Até a próxima!

## Referências

* [Durabilidade de mensagens](http://www.rabbitmq.com/tutorials/tutorial-two-python.html);
* [Modo de confirmação do RabbitMQ](http://www.rabbitmq.com/confirms.html);
