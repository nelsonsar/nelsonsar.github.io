---
layout: default
title: "O que são interfaces?"
---

A bastante tempo tenho vontade de escrever sobre OOP e acho que interfaces são um ótimo começo.

## O que é interface?

Ao contrário do que se pode pensar uma interface não depende de palavra-chave para existir, e definiria como:

- Um protocolo;
- Definição de como operações que tem um conceito em comum devem ser usadas;
- Um agrupamento lógico e coeso de ações que devem ser usadas juntas.

Antes de continuar a falar sobre programação eu vou falar sobre comunicação porque acredito que interfaces tem um papel fundamental na interação entre objetos.

### Teoria da comunicação

Quando estava no colegial estudei rapidamente [**Teoria da comunicação**][1]. A parte da teoria que me inspirou em escrever este post e a relação foi a mensagem:

*"A mensagem é, no sentido geral, o objeto da comunicação. Dependendo do contexto, o termo pode se aplicar tanto ao conteúdo da informação quanto à sua forma de apresentação."*

E ainda:

* Qualquer pensamento ou idéia expressada brevemente em um linguagem aberta ou secreta (código), preparada numa forma possível de transmissão por qualquer meio de comunicação.

* Uma quantidade arbitrária de informação cujos início e fim são definidos ou implicados.

* Informação de registro, uma corrente de dados expressados em uma linguagem aberta ou cifrada (notação) e preparada em um formato especificado para a transmissão pretendida por um sistema de telecomunicações.

**Fonte:** [**Wikipedia**][2]

Ou seja, "passar" informção de um ponto para o outro. Algo como:

Emissor -> informação -> Receptor. Parece familiar?

### A relação entre os temais e o fim do pseudo enigma criado pelo autor

Assim como na vida real o **receptor** escolhe como lidar com a **mensagem**. Mas, para que a comunicação seja bem sucedida o **emissor** tem que ter conhecimento prévio sobre o *receptor*, por exemplo:

Uma rádio que tem um público alvo com pessoas de até 15 anos não vai tocar [Stairway to Heaven][3] por um motivo bem simples: os ouvintes não vão saber como "lidar" com a música (há exceções, óbvio).

Um exemplo mais prático (e catastrófico):

<pre class="language-php"><code><?php

class Teenager
{
    public function listenToKatyPerry()
    {
        // Teenager knows this kinda of music
    }
}

$teenager = new Teenager;
$teenager->listenToLedZeppelin();
// The line above outputs: Fatal error: Call to undefined method Teenager::listenToLedZeppelin
</code></pre>


Note que se o método ```listenToKatyPerry``` fosse chamado a mensagem seria recebida e alguma ação tomada (se implementada) e poderíamos dizer que a **comunicação foi bem sucedida**.

### O que aconteceu até agora

A partir do exemplo dado na seção anterior podemos concluir que uma **interface** torna pública quais são as **mensagens** que o **receptor** consegue entender, provendo o conhecimento prévio para que a comunicação com o **emissor** seja bem sucedida. E a mais importante conclusão:

**Interfaces bem definidas fazem com que a interação entre objetos seja feita de maneira clara e consistente**

Obs.: A classe ```Teenager``` poderia ser capaz de entender mais mensagens, claro, mas, para manter a sanidade do post vou me ater a apenas um método no exemplo.

## Referências

[1]: http://pt.wikipedia.org/wiki/Teoria_da_comunica%C3%A7%C3%A3o
[2]: http://pt.wikipedia.org/wiki/Mensagem
[3]: http://en.wikipedia.org/wiki/Stairway_to_Heaven
[4]: http://inst.eecs.berkeley.edu/~cs61a/reader/aboveline.pdf
