---
layout: default
title: "Named constructors"
---

O que fazer quando você quer construir um objeto e tem aquele parâmetro opcional, aquela coisa que o usuário pode definir e que você não tem muito controle sobre ou ainda que você pode usar um padrão caso o usuário não defina? Por exemplo, o timezone na classe ```DateTime``` do próprio PHP que tem algumas variações de construção. Como posso evitar passar ```null``` no construtor da minha classe? E por que deveria me preocupar com isso?

## O grande problema de passar null para métodos

Sempre que definimos parâmetros opcionais adicionamos pelo menos mais um ```if``` em algum lugar do código. Pode ser uma verificação para usar um valor padrão ou para simplesmente ignorar o uso desse parâmetro. O problema é que geralmente esse if é duplicado em alguma outra parte, geralmente dentro da mesma classe, inclusive...
Quando temos algum processamento depois da condição (alguma operação de transformação qualquer ou até mesmo validação) fatalmente precisaremos testar processamento e acabaremos tendo teste de construtor, o que não é muito legal até porque dar nome pra esses testes geralmente é um problema.
O último e, talvez, o pior dos problemas é: a legibilidade do código piora. Por exemplo, vamos criar uma classe de cor que recebe três parâmetros: a quantidade de vermelho, de verde e azul (RGB) e tem um método que retorna a representação hexadecimal:

<pre class="language-php">
<code>
class Color
{
    private $red;
    private $green;
    private $blue;

    public function __construct($red = 0, $green = 0, $blue = 0)
    {
        $this->red = $red;
        $this->green = $green;
        $this->blue = $blue;
    }

    public function toHexadecimal()
    {

    }
}
</code>
</pre>

Claro que o exemplo é exagerado, apesar de plausível. As possíveis construções são várias, mas, imagina você se deparando com algo como:

``` $color = new Color;``` e umas linhas pra baixo ```$red = new Color(255);```.

Apesar de ser possível inferir como se dá a construção do objeto (quais são os parâmetros e qual o tipo) não dá pra falar que tá fácil ou bom de criar essas cores, né? Sem contar que já dá pra pensar nas verificações que temos que fazer mesmo se levarmos em consideração o scalar type hint. E a quantidade de testes no construtor? Foda...

Alguns podem dizer que nesse caso é muito melhor criar um método ao invés de passar esses parâmetros no construtor, mas, aí ainda teríamos o problema de chamar o método ```toHexadecimal``` antes de adicionar algum valor de cor, assim:

<pre class="language-php">
<code>
$color = new Color;
$color->toHexadecimal();
$color->setColors($red, $green, $blue);
</code>
</pre>

E, podemos lançar uma exception se chamar o método ```toHexadecimal``` antes do ```setColors```, ou seja, mais trabalho! E ainda não atingimos clareza suficiente já que podemos fazer com que os parâmetros fossem opcionais ainda...

Então, fodeu?! Não... Longe disso...

## Named constructors

Os named constructors são uma boa para construções padrões e também para possível processamento no construtor. Eles funcionam assim:

<pre class="language-php">
<code>
class Color
{
    private $red;
    private $green;
    private $blue;

    const COLOR_RED_RGB = 255;

    private function __construct($red = 0, $green = 0, $blue = 0)
    {
        $this->red = $red;
        $this->green = $green;
        $this->blue = $blue;
    }

    public static function black()
    {
        return new self();
    }

    public static function red()
    {
        return new self(self::COLOR_RED_RGB);
    }

    public static function mixedFrom($red, $green, $blue)
    {
        // Verificações diversas aqui:
        // 1. Cores entre 0 e 255;
        // 2. Não são null (ou se for null, considerar 0, sei lá)
        // 3. Os parâmetros podem ser instâncias do próprio Color
        return new self($red, $green, $blue);
    }

    public function toHexidecimal()
    {

    }
}
</code>
</pre>

Dessa forma testar ficou mais fácil e ainda seu teste vai ficar mais expressivo. Se outra cor for muita utilizada é possível definir um named constructor pra ela para evitar várias chamadas do ```mixedFrom``` espalhadas pelo código. Não é necessário se preocupar com uma chamada equivocada para os métodos de instância e no fim você só trocou uma chamada estática que o PHP provê para uma criada dentro do seu domínio que expressa com mais clareza as condições para aquela maneira de criar um objeto.

E fica legível? Opa, e como:

<pre class="language-php">
<code>
$red = Color::red();
$black = Color::black();
$white = Color::mixedFrom(255, 255, 255);
</code>
</pre>

Aí que coisa linda!

## Conclusão

Sempre que precisar de um construtor mais complexo ou quebrar um construtor complexo com vários ```if```, ```switch``` e/ou parâmetros opcionais considere usar named constructors.

Não achou legal? Quer discutir? Me xingue no Twitter e a gente pode ir adicionando a discussão ao post!

Abraço!
