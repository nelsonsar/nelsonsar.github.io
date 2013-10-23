---
layout: default
title: "Testando fixtures com data no PHPUnit"
---

Testar [fixtures](http://phpunit.de/manual/3.7/en/fixtures.html) com data nem sempre é uma tarefa fácil. Geralmente os testes falham por forçarmos uma data em uma fixture, por exemplo:

<pre class="language-markup"><code>
&lt;?xml version="1.0" ?&gt;
&lt;dataset&gt;
    &lt;table name="guestbook"&gt;
        &lt;column&gt;id&lt;/column&gt;
        &lt;column&gt;content&lt;/column&gt;
        &lt;column&gt;user&lt;/column&gt;
        &lt;column&gt;created&lt;/column&gt;
        &lt;row&gt;
            &lt;value&gt;1&lt;/value&gt;
            &lt;value&gt;Hello buddy!&lt;/value&gt;
            &lt;value&gt;joe&lt;/value&gt;
            &lt;value&gt;2013-10-20 17:15:23&lt;/value&gt;
        &lt;/row&gt;
        &lt;row&gt;
            &lt;value&gt;2&lt;/value&gt;
            &lt;value&gt;I like it!&lt;/value&gt;
            &lt;null /&gt;
            &lt;value&gt;2013-10-21 12:14:20&lt;/value&gt;
        &lt;/row&gt;
    &lt;/table&gt;
&lt;/dataset&gt;
</code></pre> 

O trecho acima foi retirado da documentação oficial do [PHPUnit](http://phpunit.de/manual/3.7/en/database.html#database.available-implementations) com uma pequena mudança e mostra como utilizamos datas no nosso dia a dia.

Conversa afiada de lado e, mais importante, problema apresentado, vamos ao que interessa um exemplo de verdade. Vamos supor que seu gerente pediu que você listasse as entradas mais recentes do nosso guestbook. A regra para ser uma entrada recente é: **Todas que foram registradas no intervalo do dia de hoje menos dez dias**. Como somos bons desenvolvedores, antes de mexer no código vamos escrever um teste:

<pre class="language-php"><code>
&lt;?php

class GuestbookRepositoryTest extends DatabaseTest
{
    protected function getDataSet()
    {
        //Esse é o arquivo que foi mostrado no começo do post
        return $this->createXMLDataSet(__DIR__ . '/fixtures/guestbook.xml');
    }

    public function testShouldReturnRecentEntries()
    {
        $expectedEntries = array(
            array(
                'id' => 1,
                'content' => 'Hello buddy!',
                'user' => 'joe',
                'created' => '2013-10-20 17:15:23',
            ),
            array(
                'id' => 2,
                'content' => 'I like it!',
                'user' => null,
                'created' => '2013-10-21 12:14:20',
            ),
        );

        $repository = new GuestbookRepository;

        $entries = $repository->getRecentEntries();

        $this->assertEquals($expectedEntries, $entries);
    }
}
</code></pre>

O ciclo do TDD acaba e você entrega a feature. Dez dias depois você está apreciando seu café e um companheiro de trabalho se aproxima e fala que você quebrou a suite de testes. Sem entender, você dá uma olhada e realmente percebe que ela foi quebrada por você e seu teste de entradas recentes, no impulso você altera a fixture e o teste volta a passar.

A pergunta é: Você vai ficar **PRA SEMPRE** corrigindo esse teste na mão? Eu espero que não... E apresento uma alternativa para isso abaixo:

<pre class="language-markup"><code>
&lt;?xml version="1.0" ?&gt;
&lt;dataset&gt;
    &lt;table name="guestbook"&gt;
        &lt;column&gt;id&lt;/column&gt;
        &lt;column&gt;content&lt;/column&gt;
        &lt;column&gt;user&lt;/column&gt;
        &lt;column&gt;created&lt;/column&gt;
        &lt;row&gt;
            &lt;value&gt;1&lt;/value&gt;
            &lt;value&gt;Hello buddy!&lt;/value&gt;
            &lt;value&gt;joe&lt;/value&gt;
            &lt;value&gt;##DATE##&lt;/value&gt;
        &lt;/row&gt;
        &lt;row&gt;
            &lt;value&gt;2&lt;/value&gt;
            &lt;value&gt;I like it!&lt;/value&gt;
            &lt;null /&gt;
            &lt;value&gt;##DATE##&lt;/value&gt;
        &lt;/row&gt;
    &lt;/table&gt;
&lt;/dataset&gt;
</code></pre> 

Note que as datas *hardcoded* foram substuídas por um *placeholder* `##DATE##`.

<pre class="language-php"><code>
&lt;?php

class GuestbookRepositoryTest extends DatabaseTest
{
    protected function getDataSet()
    {
        //Esse é o arquivo que foi mostrado no começo do post
        $dataSet = $this->createXMLDataSet(__DIR__ . '/fixtures/guestbook.xml');
        $replacedDataSet = new PHPUnit_Extensions_Database_DataSet_ReplacementDataSet($dataSet);

        $date = new DateTime('-1 day');

        $replacedDataSet->addFullReplacement('##DATE##', $date->format('Y-m-d H:i:s'));

        return $replacedDataSet;
    }

    public function testShouldReturnRecentEntries()
    {
        $createdDate = new DateTime('-1 day');

        $expectedEntries = array(
            array(
                'id' => 1,
                'content' => 'Hello buddy!',
                'user' => 'joe',
                'created' => $createdDate->format('Y-m-d H:i:s'),
            ),
            array(
                'id' => 2,
                'content' => 'I like it!',
                'user' => null,
                'created' => $createdDate->format('Y-m-d H:i:s'),
            ),
        );

        $repository = new GuestbookRepository;

        $entries = $repository->getRecentEntries();

        $this->assertEquals($expectedEntries, $entries);
    }
}

</code></pre>

E nos testes passamos a usar a classe `PHPUnit_Extensions_Database_DataSet_ReplacementDataSet` que irá substituir todas as ocorrências do placeholder `##DATE##` pelo valor definido no segundo parâmetro do método `addFullReplacement`. Dessa forma o teste passará independente do tempo de sua criação ou alteração.☮

Obs.: O recurso de substituição é custoso, portanto, deve-se usá-lo com sabedoria para que sua suite de testes não comece a ficar muito lenta.
