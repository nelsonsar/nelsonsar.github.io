---
layout: default
title: "Não retorne null! E retorno o que, então?"
---

No capítulo 7 do excelente [Clean Code](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) o Uncle Bob é enfático:

Não retorne null! **Retornar null cria mais trabalho para nós mesmos!**

Vou te convencer com apenas um argumento: Toda vez que retornamos ```null``` colocamos mais um ```if``` na vida, para garantir que nossa aplicação não exploda em algum ponto que não esperávamos.

Convencido? Ótimo! E o que retornar, então?

## Quando o retorno for uma collection (ou um array mesmo)...

Esse, é o melhor dos mundos. Dificilmente você retorna uma coleção e não itera sobre ela na sequência, portanto, retornar uma collection ou um array vazio deve ser o suficiente para evitar a checagem de null. A única exceção que consigo enxergar é no caso de usar um ```for```, que tentará acessar uma chave inexistente do array ou da collection, aí é trocar a checagem de null por uma de vazio e, nesse caso meu poder de convencimento é limitado a dizer que retornar null quebra o contrato definido por sua classe com seu clientes.

## Quando o retorno for um objeto

Aí temos um problema... Tanto o [Uncle Bob](https://twitter.com/unclebobmartin) quanto o [Martin Fowler](https://twitter.com/martinfowler) falam sobre o [**special case objects**](http://martinfowler.com/eaaCatalog/specialCase.html). Esses caras são responsáveis por manter uma mesma interface durante a troca de mensagens entre objetos. Então, ao invés de acordar com seus colegas de trabalho que o null representa, retorne um objeto com a mesma interface que represente o caso anteriormente representado pelo null. O NullObject é um tipo de **special case**, ou seja, nem todo **special case** é um NullObject (Nossa, minha didática já foi melhor...).

Implementar um **special case** pra cada um dos objetos que retornam null em algum momento vai ser um grande problema, tanto pela explosão de classes especiais quanto pela quantidade de lugares que precisarão ser alterados. E eu só escrevi essa merda toda porque eu li esses dias sobre a class ```Maybe``` atualmente presente no Java 8 (No Java chamada de [Optional](http://docs.oracle.com/javase/8/docs/api/java/util/Optional.html)), mas, que descobri lendo o [GOOS](http://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627/).

A proposta da classe é bem simples: Prover um container que encapsula tanto o objeto quanto o null que sabe informar se o objeto está lá ou não.

Beleza, mas, entre usar ```isPresent()``` ou ```(null === $this->seuMetodoMarot())``` a vantagem vai onde?

Como eu disse acima, retornar null implica em definir um acordo entre os desenvolvedores ou entre classes que trocam mensagens. Isso só ficará explícito em algum tipo de comentário ou documentação e no código a não ser que seja por ação externa (leia usar uma IDE) isso seria visível (através de docblocks, etc). A idéia aqui é tornar o código legível sem a necessidade desse acordo entre cavalheiros (afinal, você diz pelo tipo de objeto que o valor pode ou não estar presente), ou pelo menos, como o quote abaixo define, dar nome ao null. Pensando que na maioria das vezes tomamos uma ação quando o valor retornado é nulo, podemos criar um método ```ifEmpty``` que recebe um callback e redirecionar o fluxo para apenas um ponto na aplicação.

<em>"Besides the increase in readability that comes from giving null a name, the biggest advantage of Optional is its idiot-proof-ness. It forces you to actively think about the absent case if you want your program to compile at all, since you have to actively unwrap the Optional and address that case. Null makes it disturbingly easy to simply forget things, and though FindBugs helps, we don't think it addresses the issue nearly as well.</em>

<em>This is especially relevant when you're returning values that may or may not be "present." You (and others) are far more likely to forget that other.method(a, b) could return a null value than you're likely to forget that a could be null when you're implementing other.method. Returning Optional makes it impossible for callers to forget that case, since they have to unwrap the object themselves for their code to compile."</em>

Esse quote foi extraído [daqui](http://code.google.com/p/guava-libraries/wiki/UsingAndAvoidingNullExplained).

A moral da história é que usar o ```Maybe``` nos força a evitar o null tanto no retorno quanto como parâmetro o que, segundo o Uncle Bob é também uma maneira de tornar o código limpo.

## Vamos usar o Maybe/Optional pra tudo! E teremos um código limpo! Aeeee!

Calma! As coisas não são assim... Sair substituindo todos trechos de código com o ```Maybe``` é um esforço, talvez, desnecessário. Existem casos que o null faz parte da lógica como no caso da [Three valued logic](http://en.wikipedia.org/wiki/Three-valued_logic), casos em que devemos retornar exceções (de preferência que façam sentido no domínio da sua aplicação) e casos em que a convenção em retornar null é realmente válida (No SQL null significa a ausência de dados).

Então, use isso com cautela e PENSANDO com força se é isso mesmo que você quer fazer.

## Referências

Para os links do Stack Overflow é importante ler as respostas!

* [http://stackoverflow.com/questions/271526/avoiding-null-statements-in-java](http://stackoverflow.com/questions/271526/avoiding-null-statements-in-java)
* [http://programmers.stackexchange.com/questions/120355/is-it-better-to-return-null-or-empty-values-from-functions-methods-where-the-ret](http://programmers.stackexchange.com/questions/120355/is-it-better-to-return-null-or-empty-values-from-functions-methods-where-the-ret)
* [http://www.javacodegeeks.com/2013/09/deep-dive-into-optional-class-api-in-java-8.html](http://www.javacodegeeks.com/2013/09/deep-dive-into-optional-class-api-in-java-8.html)
* [http://code.google.com/p/guava-libraries/wiki/UsingAndAvoidingNullExplained](http://code.google.com/p/guava-libraries/wiki/UsingAndAvoidingNullExplained)
* [http://stackoverflow.com/questions/11561789/guava-optional-how-to-use-the-correct](http://stackoverflow.com/questions/11561789/guava-optional-how-to-use-the-correct)
* [http://stackoverflow.com/questions/18681243/should-i-use-java8-guava-optional-for-every-method-that-may-return-null](http://stackoverflow.com/questions/18681243/should-i-use-java8-guava-optional-for-every-method-that-may-return-null)
* [http://objitsu.blogspot.com.br/2013/01/php-and-maybe-miserable-monads.html](http://objitsu.blogspot.com.br/2013/01/php-and-maybe-miserable-monads.html)
* [http://blog.ircmaxell.com/2013/07/taking-monads-to-oop-php.html](http://blog.ircmaxell.com/2013/07/taking-monads-to-oop-php.html)
