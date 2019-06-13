---
layout: post
title: "Dando nome ao código: Classes"
---

Existe um problema muito grande no design de sistemas com orientação a objetos que é a "coisificação". Esse problema fica evidente ao se ler os nomes das classes: Manager, ServiceLocator e Adapter são alguns exemplos dessa obsessão de transformar qualquer ação de um sistema em uma coisa, em um substantivo.

Essa obsessão tem raízes na ascenção[[1]][1] do paradigma orientado a objetos e da linguagem Java. Mas a popularidade do Java trouxe também uma enorme ênfase ‒ presente em sua extensa bibliografia, cursos de certificação e documentação oficial ‒ a relação "coisas executam ações"[[2]][2]. Ou seja, verbos (métodos) estão atrelados a substantivos.

Só que essa obsessão fere o design dos objetos. Coisificar termina, na maioria das vezes, criando uma solução não orientada a objetos. É um atalho para criar um modelo anêmico e para proliferar programação procedural em um código teoricamente orientado a objetos.

A boa notícia é que há como fugir dessa armadilha. Mas antes disso, precisamos entender como que a "coisificação" funciona.

## A "coisificação"

A grande maioria dos desenvolvedores usa o Inglês para escrever código e, isso acabou se tornando um grande trunfo no processo de transformar tudo em substantivo.

Para transformar um verbo em um substantivo em Inglês temos dois caminhos[[3]][3]:

1. Prefixando um artigo "a" antes do seu uso
2. Usando os sufixos: "er", "or", "tion" or "sion"

Como uma classe geralmente não usa conectores e nem artigos, a segunda opção foi a escolhida para resolver a limitação imposta pelo Java. E, partir daí apareceram alguns nomes conhecidos: Manager[[4]][4], *ServiceLocator*, *Adapter* e, a lista continua. Se antes eu tinha:

```python
def send_notification(value, from, to):
    # Logic to send a notification
```

Agora eu tenho:

```python
class NotificationSender:
    @staticmethod
    def send_notification(notification, from, to):
        # Logic to send a notification
```

Claro que a nova classe podia ser o `NotificationManager` ou quem sabe o `NotificationService`. Apesar de não parecer, essas ações disfarçadas de coisas, estão longe de ser orientação a objetos - apesar de estar numa classe, o método `send_notification` é estático, ignorando a ideia que um objeto tem dados e métodos (essa definição tem raras exceções, como por exemplo os serviços em DDD[[5]][5]) - e, o nome, na minha opinião é o maior culpado de tudo isso.

## Objetos sem estado, modelos anêmicos e, serviços

O nome da classe diz muito sobre o papel dela numa aplicação. O grande problema, na minha opinião, é que como desenvolvedores nos prendemos demais aos detalhes técnicos do que ela vai fazer.

Então, se múltiplos objetos vão mandar notificações qual é o problema de se ter um `NotificationSender`?

O primeiro, de um ponto de vista "purista" é a falta de estado. A principal vantagem de se usar orientação a objetos e de poder dados e ações num mesmo lugar com barreiras bem definidas, sem dados globais ou funções espalhadas por toda aplicação (com possíveis duplicações). A partir do momento que ignoramos a existência de estado num objeto, deixamos também de considerar o papel dele - não técnico - como parte do domínio que estamos trabalhando. Em outras palavras, é como se todo nosso negócio fosse uma gigante camada de infraestrutura.

O segundo ponto, ligado ao primeiro, é a explosão de objetos que só tem dados. É normal que existam objetos que representem informação, - dados combinados que formam algum elemento do domínio - o problema é quando eles só existem pra algum outro objeto que executa ações funcione, criando um modelo anêmico[[6]][6].

O terceiro é relacionado a talvez a confusão criada com o termo "serviço". E, isso é inclusive algo que o Eric Evans alerta no Blue Book[[7]][7]:

> *"Now, the more common mistake is to give up too easily on fitting the behavior into an appropriate object, gradually slipping toward procedural programming... SERVICES should be used judiciously and not allowed to strip the ENTITIES and VALUE OBJECTS of all their behavior."*

O que se espera de um serviço é que ele represente uma operação que não "cabe" em uma entidade ou objeto de valor, seja stateless mas, que principalmente, represente uma ação (com parâmetros e resultados representados no domínio), ou seja, nomeado como um verbo. Apesar de um "executador" ser *aceitável*, segundo o próprio Evans, a ressalva feita é muito mais importante que a implementação em si.

Assim, como no refactoring, esses são os "cheiros" que eu considero mais importantes na relação entre nomes e problemas de design então, nada mais justo do que analisar a estrutura desses nomes e, mostrar algumas alternativas pra eles.

## Analisando nomes e soluções

Quando eu paro para analisar nomes eu geralmente adoto uma dessas três estratégias:

1. A partir do nome da classe, criar um objeto com estado e métodos operando nesse estado.
2. Converter a classe num serviço mudando seu nome para um verbo que deixa claro o objeto que ele opera.
3. Criar um terceiro objeto que relaciona dois outros (que podem ser a entrada e saída ou só um termo que não foi mapeado)

### Um novo objeto com estado e métodos

O nome da classe no nosso exemplo (`NotificationSender`) pode ser quebrado em duas partes: `Notification` e `Sender`. A primeira parte é a "coisa" em si e, a segunda é a ação desempenhada por ele, sua especialidade. A partir daí podemos criar um objeto (ou modificar um existente):

```python
class Notification:

    def __init__(self, from, to, message):
        self.from = from
        self.to = to
        self.message = message

    def send(self):
        # send the notification thru some adapter/media
```

Esse caso faz sentido quando:

* Queremos fazer alguma transformação com algum dos componentes do estado, sanitizar a mensagem, por exemplo.
* Algum tipo de lógica que envolve domínio, por exemplo, a notificação tem algum tipo de regra de envio e, queremos ter um lugar para alocar a mesma. É importante notar que isso pode causar problemas e corromper o objeto, se as regras estiverem misturadas com a lógica de envio podemos ter sérios problemas.
* Uma nova funcionalidade vai ser adicionada e é a relacionada a ação do objeto. No nosso caso, podemos adicionar lembretes para uma notificação, por exemplo, mas, queremos definir eles em tempo de execução usando um método como `add_reminder`.

Entretanto, se adotássemos essa estratégia aqui teríamos que resolver como lidaríamos com a parte de infraestrutura (qual mídia vai ser usada). Algumas soluções:

* Introduzir um colaborador que faça essa escolha baseada em configuração (quase um contâiner de injeção de dependência) mas, a complexidade talvez não se pagasse.
* Esse adaptador poderia ser um parâmetro do método `send` o que aumentaria a complexidade no entorno das chamadas de notificação.

Além disso, talvez não faça sentido ter uma representação da notificação. Nós só precisamos enviar uma notificação, assim como veremos na próxima estratégia.

### Conversão em serviço

A conversão em serviço é o caminho inverso da estratégia anterior. Não temos motivos para manter o estado em um objeto e a operação parece não pertencer a outro objeto. A operação poderia pertencer mas:

* No nosso domínio ela é irrelevante. Exportar dados em arquivos de diferentes formatos é geralmente irrelevante nos domínios, num e-commerce gerar um lista de pedidos em CSV não é importante para o negócio funcionar ou ser um diferencial logo, não vale a pena criar um método na coleção de pedidos para executar essa ação.

* É uma operação que envolve interagir com sistemas externos. O exemplo de serviço de domínio do Blue Book[[7]][7] é ótimo, apesar de ser possível criar um objeto representanto uma transferência entre contas, lidar com serviços externos dentro de uma entidade pode ser estranho ou difícil (como vimos na estratégia anterior) então, usamos um serviço para tal finalidade.

No caso, do nosso exemplo, a classe `NotificationSender` parece ser um serviço já que lidar com sistemas externos seria mais simples. Então, a maior mudança nesse caso seria seu nome: de `NotificationSender` para `SendNotification` (ou, uma função, por que não?) fazendo ele realmente parecer uma ação.

### Um terceiro objeto

Como já sabemos, serviços devem ser usados com parcimônia e devem ter as características descritas na estratégia anterior. Mas, algumas vezes nos empolgamos em seguir algum padrão. Entretanto, no caso do padrão Service, corremos o risco de acabarmos com código procedural em classes.

Essa última estratégia ajuda a achar objetos escondindos ao criticar a relevância da existência de serviços existentes no modelo.

Imagine que temos a seguinte classe em um domínio de recrutamento de candidatos para vagas de emprego:

```python

class ScheduleService:

    def schedule_interview(self, candidate, job, date):
        # schedule interview logic
```

As vezes deixamos passar objetos ou ações em objetos importantes para o domínio. Nesse domínio específico uma entrevista é uma parte importante e, o serviço não deveria tirar essas capacidade dela. Dessa forma, a ação de agendamento volta para o objeto entrevista (interview) e o serviço deixa de existir:

```python
class Interview:

    def __init__(self, job, candidate):
        # initialize state

    def schedule(self, date):
        # logic to schedule
```

Esse é um caso em que um terceiro objeto só existe se outro objeto existir. As condições para que exista uma entrevista (interview) é que exista uma vaga (job) e um candidato (candidate) então, o estado é extremamente importante nesse objeto. Além disso, as regras de negócio envolvidas no processo de agendamento podem ser complexas e fundamentais para o domínio.


[1]: https://en.wikibooks.org/wiki/Java_Programming/History
[2]: http://steve-yegge.blogspot.com/2006/03/execution-in-kingdom-of-nouns.html
[3]: https://dzone.com/articles/pitfalls-naming-classes
[4]: https://blog.codinghorror.com/i-shall-call-it-somethingmanager/
[5]: https://en.wikipedia.org/wiki/Domain-driven_design
[6]: https://martinfowler.com/bliki/AnemicDomainModel.html
[7]: http://domainlanguage.com/ddd/
