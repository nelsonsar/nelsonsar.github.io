---
layout: default
title: "Vim: Listando métodos de uma classe"
---

Hoje me deparei com uma classe gigantesca e precisa listar rapidamente seus métodos. Então, matutei como eu poderia compor uma lista de métodos no vim e cheguei nessa solução bem fácil.

<img class="img-responsive" src="http://i.imgur.com/P2Y6UUF.png?1" alt="resultado" />

No **command mode** do seu vim digite ```vimgrep /on .*(/ %```.

Esse comando vai fazer com que o vim popule a [quickfixlist](http://vimdoc.sourceforge.net/htmldoc/quickfix.html) com os resultados que batem com a pattern ```on .*(```. A partir daí você pode usar ```:cn``` e ```:cp``` para navegar pelos resultados.

Mas, se assim como eu você vem de uma IDE e gosta de janelinhas e poder clicar nos nomes dos métodos pra navegar entre eles você pode usar o ```:cw```. Assim que você executar o ```:cw``` um [split](http://vimdoc.sourceforge.net/htmldoc/windows.html#opening-window) com o conteúdo do quickfix aparece e é aí que entra a mágica do vim.

O quickfix vai listar a linha que está a assinatura do método e o melhor você pode navegar entre eles simplesmente usando o enter.
