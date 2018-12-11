---
layout: default
title: "Duplication"
---

Duplication is something I have a hard time dealing with. It's amongst the things I have on my review checklist and one of the things that - in my humble opinion - when removed make software design much better. It was classified as a bad smell in 1999 by Fowler, and I thought that, almost 20 years later, saying *"duplication is not good"* won't be needed. I was wrong.

### Duplicated code as an intention

First, it's important to say that duplication will happen. I'm not saying we should go AND BURN ALL DUPLICATION! Also, I'm not saying that I never duplicated code (copied and pasted, whatever) or that I hate you because you did so. Before going any further, it's important to draw a line between express something and repeat things without thinking about anything. [A helpful way](http://www.extremeprogramming.org/rules/simple.html) to recognize these two ideas is:

> Consider a simple example; you multiply by 100 to turn a fraction into percentage and you also multiply by 100 to turn meters into centimeters. Should you have a single function that multiplies by 100 called `convertToPercentOrMeters(x)`? NO! Not even if it would remove some duplication. You want two methods; `convertToPercent(aFraction)`, and `convertMetersToCentimeters(aLength)`. You want two because they tell you different things. Not just that you will multiply by 100 but also why you will multiply by 100 and what kinds of numbers are valid inputs.

Besides the fact the example is too simple, it shows that even with the structural duplication that will be created we **should** represent different concepts in our design. Also, duplication gives us some opportunities...

### Duplicated code as missing concept

Copying and pasting something is far easier than writing things from scratch. Sometimes, while finding an abstraction, it's easier to duplicate code [to see common patterns and extracted them](https://martinfowler.com/ieeeSoftware/repetition.pdf). It may be a superclass, a new collaborator or even a function that helps you to get to an idea that makes the duplication gone. If you do TDD, you can use the refactoring step go thru the duplication and remove it having tests to back you up. The problem is people taking [Sandi Metz quote](https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction) to spread unjustified duplication all over the code... I agree with her, don't get me wrong, it's far easier to duplicate code to find a better (or brand new) abstraction but, she never told you should stop right there - she meant it as a process to isolate and extract patterns from the duplications you created.

### Duplicated code as lack of experience

If you feel you don't have enough experience dealing with something, ask around. As I stated before creating duplicated code can be part of the design process and, sometimes we get lost while doing something we're not familiar with and that's is OK! But, it's part of your job ask around for better solutions, researching the topic, etc. So, don't stop at the duplication, try to make something better out of it (you may create the wrong abstraction in the process as well, it's part of the job too).

Up to this point we found some opportunities duplication can offer to us (teaching, learning, refactoring) but, can also lead to some bad things (which is the point here).

### Duplicated code as tech debt

Unless you're losing money because of bug, duplication should live at the worst quadrant of tech debt: reckless and deliberate. Why? Because creating duplicated code is easy enough to fix a bug hurting your business but, too easy to create a mess, leading to other bad things...

### Duplicated code as disrespect

If you need to submit your code to reviews and there's a ton of duplication - without any notice reasoning the duplicated code; you're disrespectful. Why? You probably send (you often don't write duplicated code, you copy and paste it) more code than you should and it'll take more time from the reviewer to get to what matters. In my opinion, you're making other people lives harder by "doing your job" or any different answer like that.

### Duplicated code is alive so, brace yourselves

The thing about the duplicated code in this particular case is: your intents with it may not be the same that created the original one. Why is it bad? It'll  become harder to spot the duplication (because of different naming, or anything related to a different person with a different idea may lead) and at some point the code is still duplicated (the concept is the same) but, its structure is so different from the original one that is refactoring it, or even finds that it's an actual duplication, will take much more time than trying to figure out which concept it's trying to express.

### Duplicated code as a box of problems

Even when duplication seems to be the only way to do something I think a lot about it and I firmly believe that [Duplication (inadvertent or purposeful duplication) can lead to maintenance nightmares, poor factoring, and logical contradictions](http://wiki.c2.com/?DontRepeatYourself) and that's why - after seeing a lot of this happening in my life - I have a hard time with duplicated code.
