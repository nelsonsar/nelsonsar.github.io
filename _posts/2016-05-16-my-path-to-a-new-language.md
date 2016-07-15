---
layout: default
title: "My path to a new language"
related: [
    "TDD: How to use Math to get into it",
    "Aprendendo uma nova linguagem"
]
---

## Some background...

My first job as a developer was back in 2008 as an intern. In this company they used MS Visual Basic 6 and the weird [Pervasive SQL](https://en.wikipedia.org/wiki/Pervasive_PSQL). They spent (spent is not a good word in this context) a whole month teaching the interns how to code, how to write some basic SQL and after that I was solving some minor bugs. In other words, I was been paid to learn! Isn't it the best job ever?!

I was pretty happy with Visual Basic: I wrote some programs to help my father with backups and migrations of his Access database/system and I did a little keystroker to help me collect loot for a MMORPG too! At this point I was earning a lot of money (for a 19 year old boy) and my father told me that I could even become a manager.

But, one day, in the lunch time, I saw one of my intern fellows writing some PHP in notepad. He convinced me that PHP and web applications would rule the world. I was so down for it that I bought my first tech book: [Learning PHP and MySQL](http://shop.oreilly.com/product/9780596101107.do), in the same day after work. The the next day I installed [WAMP](http://www.wampserver.com/en/) in my machine and spent (spent is not a good word in this context) all my spare time writing PHP.

Some months later I was hired by another company as a PHP developer intern! And from this day until August, 2015 I had a very, very happy marriage with PHP: I started to go to conferences, I met most of my friends and learned A LOT (most things that I've learned so far I did writing PHP and discussing with my PHP developer friends)!

In 2015 I went to [Weta Cave](http://wetaworkshop.com/visit-us/workshop-tours/) in New Zealand and when I left the tour I decided that was time to change again (I felt that I wasn't being creative or learning something new for some time, and this was making me unhappy and not productive). When I arrived in Brazil I asked my CTO ([@marcelioleal](https://twitter.com/marcelioleal)) if I could join the mobile team and he said that would be awesome for me to try something different and agreed with the idea without blinking. I must confess, the feeling of starting over again is strange: it's very scary but it's very motivating too! I was really happy to learn new things and to learn C#, I developed a kind of "framework" to help me learning a new language which is the motivation of this post.

## The "framework"

### The basics or where to start?

One of the most chalenging things of learning a new language is learning the basics of it. How to write an ```if``` statement, a loop and the data structures available. Some people may tell you to read the documentation, which is a good advice but not very practical, since you can do it while you're learning and in this stage it's really important to get feedback quickly.

My advices in this step:

* Search for online resources like [Codecademy](https://www.codecademy.com/). Codecademy provides **AWESOME** courses for free and have a clean and really fast UI to help you grasping errors.
* Search a book for beginners (the Beginning with X: From novice to professional is a good start) - I found that Quora lists gives better alternatives than StackOverflow for lists like this.
* Use 1 hour (average) to complete the course and/or read the book per day (avoid the burnout, folks) - Take your time just remember to live your life too.

By reading the book and doing the course you can apply some concepts read in the book and get feedback fast enough. The most important part here is to get used to the syntax, gotchas and other language habits, if you're feeling slow don't panic! It's really important to pay attention to the basics now, we'll get more practical in the next phase.

### Getting some shit done

After getting used to the syntax and some of the basics of the new language it's time to get something done! There are lots of problems out there to be solved in form of Katas, for example, but they may get you confused or frustrated so let's start with something less complicated. I've already written about [Project Euler](https://projecteuler.net/) and do think that the first problems there are simple enough to not get you frustrated and hard enough so you can try the things you learned already. This step is the one that you should try a test framework for the new language, [Project Euler's problems are a great way to get used to tests](http://nelsonsar.github.io/2016/02/23/How-I-practice-TDD.html).

My advices in this step:

* Solve first 3 problems in Project Euler - Try to use TDD to get used to the language test framework.
* Search for implementations of the problems and also different ways of resolving simple problems like loops, one liners, etc. - It's important to solve the problems using the best practices of the new language.

### Solve a bigger problem

At this point you should be able to grasp a bigger problem with some ease. I do recommend the [Craps game](https://en.wikipedia.org/wiki/Craps) because the rules are fair simple and its fun enough to get some feedback. You can use these rules:

*Craps is a game played with a pair of dice. In the game of craps, the shooter (the player with the dice) rolls a pair of dice and the number of spots showing on the two upward faces are added up. If the opening roll (called the ‘coming out roll’) is a 7 or 11, the shooter wins the game. If the opening roll results in a 2 (snake eyes), 3 or 12 (box cars), the shooter loses, otherwise known as ‘crapping out’. If the shooter rolls a 4, 5, 6, 8, 9 or 10 on the opening roll, then he or she must roll the same number before rolling a 7 to win the game. For example, if the shooter rolls a 6 on the come out roll, a 10 on the second roll and a 7 on the third roll, the shooter loses since he rolled a 7 before rolling another 6. If, however, he rolled a 6 on the third roll, he wins the game.*

I got these rules from [this source](http://webpages.math.luc.edu/~jdg/w3teaching/comp_170/sp01/PDF/craps).

There are a lot of problems that were meant to be solved in Katas that often offer great challenges too. You can find a lot of them [here](http://codingdojo.org/cgi-bin/index.pl?KataCatalogue)!

In this step you should be able to start a more advanced book (from intermediate to experienced level). Keep the 1 hour average and enjoy the reading!

### Practice, practice, practice

After finishing the last book (or not) you should keep practicing on daily basis. Start to contribute to OSS software, write your own utility software or if you feel ready apply for a job in this new language (you can also try to introduce components in the new language which may be easier).

My advices in this step:

* Subscribe and solve challenges in [exercism.io](http://exercism.io/). Exercism is an **amazing** and free platform that offer challenges that will gradually becoming harder to solve. One of the most insteresting feature of the platform is: people can give you feedback on your solution, another great feature for improving your code is the possibility of seeing other person solution and learn too!

* You can find OSS projects that need help [here](http://up-for-grabs.net/#/). There are lots of projects in different languages waiting for your contribution there!

* Try to find more advanced books. Books that shows how to use refactoring techniques, that talk about frameworks and its guts, OOP and OOD in a specific language may help you to see how very smart people solve problems using the language and its power. As [Marcelo](@MarcVit) said in this step is really interesting to search for books that serve as references for the language, some good examples are: **The C# Programming Language**, **"Essential C#"**, **The Ruby Programming Language** and **Programming Ruby**. Marcelo also pointed [Ruby Koans](http://rubykoans.com/) as another awesome way to learn and practice Ruby and can't agree more.

## Final thoughts: My path to Ruby

I followed this framework for C#, Python and it's working pretty well for Ruby! Python and Ruby are pretty different from the others languages that I've worked with (lots of syntax sugar, builtin methods with different names for objects like strings, numbers) so the basics are more important than never. Since I'm a very lucky guy I was able to get a job at Glio! I'm learning lots of things and I'm able to practice in a real codebase things that I read in books and articles about the language. I'm on my fourth Ruby book and I'm still learning new things about the "basics" stuff all time. My final advice is: don't give up and have fun learning a new language, it's one of the most challenging things that a developer can do.

If you're having trouble learning a language, please ping me and I'll be glad to help you out with that.
