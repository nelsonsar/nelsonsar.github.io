---
layout: default
title: "TDD: How to use Math to get into it"
---

## Who wants to start?

This post was written thinking: "How to teach new devs TDD", but if you're an experienced developer and is searching for a way to start doing it may surprise you. I also use this "technique" to get used to new unit test frameworks and explore language constructions and best practices.

## Starting something is really hard...

I've been working with TDD and tests for while now. The first time I heard about that was in 2011 and since then I've being studying ways of teach and advocate it in the places I worked.

The thing is: Starting with tests is **REALLY** hard (it was for me... maybe that's not your case). I didn't know how to start, how to organize things inside the test method and **WHAT** to test...

In my opinion the biggest problem I faced was: I was trying to TDD on a real production codebase. And now people that do TDD for years will start to crucifying me for saying something like this, but, I'll try to make my point from now on...

## The problem of real production codebases

Real production codebases are difficult. They're big, they use a lot of third-party code and may have a ton of bad code (which is hard to test even for experienced devs). Trying to show how TDD is good when the code is not good is awesome, but for people that never worked with tests is pretty hard and a frustrating experience (for both devs involved).

You can try to explain TDD with new code that is needed in an existing codebase too! But, both devs should be able to talk about the same "thing" i.e. talking about OOP, OOA, DDD, etc in the same level, which may not be the case and BANG! Another dose of frustration... Your refactor may take a day because you need to find a way to plug this new code in a messy class and another frustration dose is in front of you...

So, I **definitely** do not recommend start TDD with real production codebases.

P.S.: Although experienced devs may be able to tackle TDD easily, I don't think the concepts of TDD will be clear enough, so if you're an experienced developer trying to understand TDD's concepts, some organization, etc this post may be useful to you too.

## Start something with simple things

It's very hard to learn something new when you need to deal with another variables. Let's think together:

When you started learning how to code you didn't need to think about classes and S.O.L.I.D, right?

When you're learning about OOP you don't need to deal with coupling nor domain, right?

So, why you need to think about all this stuff when you're learning TDD?! It doesn't make sense to me... And because of I think that we can use a stablished and stable domain with problems that can be solved with one or two collaborators (and even simple functions). And Math has all these characteristics!

In 2011 a workmate and a great master, [Diogo Baeder](https://github.com/diogobaeder), showed me [Project Euler](https://projecteuler.net/) and I fell in love with it. It has a LOT of Math problems that are simple enough to anyone that knows basic operations to solve but, the outstanding feature is: It gives you a simpler case already solved! Here is the first problem that the site shows:

![Project Euler's example](http://i.imgur.com/Cy5h0G7.png)

And my proposal is: Let's use Project Euler to teach TDD! And to do that you can use my crash course below.

## Crash course

Let's first think that we need a case to make the first test and, guess what? Project Euler's problems ALWAYS give one for us, check it out:

![Project Euler's use case](http://i.imgur.com/mmOtWjS.png)

So we'll start by writing a test for this case: we expect that our multiple calculator class returns **23** when we pass **10** as parameter to its method ```sum```. Let's do it!

{% highlight python lineos %}

import unittest
from euler import MultipleCalculator

class TestMultipleCalculator(unittest.TestCase):
    """Calculate the sum of all multiples of 3 and 5"""

    def test_sum_of_multiples_below_10(self):
        expected = 23
        multiple_calculator = MultipleCalculator()

        self.assertEqual(expected, multiple_calculator.sum(10))

{% endhighlight %}

And our test is done! We're right now in the **Red** stage of the [Red, Green, Refactor](http://www.jamesshore.com/Blog/Red-Green-Refactor.html) cycle!

Now, we'll implement the class itself to reach the **Green** stage, follow me!


{% highlight python lineos %}


class MultipleCalculator(object):

    def sum(self, limit):
        result = 0
        for x in range(1, limit):
            if x % 3 == 0 or x % 5 == 0:
                result += x

        return result

{% endhighlight %}

Now our tests should pass and we need to improve our class code to reach the final stage: **Refactor**!

This stage cannot be skipped and is the **MOST** important one, but if you don't know Python or you want to do it in another language, a good way to know if you should refactor something is follow [object calisthenics](https://www.cs.helsinki.fi/u/luontola/tdd-2009/ext/ObjectCalisthenics.pdf) and the language coding standards (I'll not talk about OOP not S.O.L.I.D here, sorry).

After our refactoring we should have a class like:

{% highlight python lineos %}


class MultipleCalculator(object):

    def sum(self, limit):
        return sum([number for number in range(1, limit) if self.__is_divisible(number)])

    def __is_divisible(self, number):
        return number % 3 == 0 or number % 5 == 0


{% endhighlight %}

Finally, we've completed a TDD cycle and we can solve the problem by exchanging **10** by **1000** in our test or creating a simple script to get the answer.

After doing 5 or 6 exercises you should be able to identify what need to be tested and how to achieve the result by repeating the Red, Green, Refactor mantra and it's time to find new ways to improve your TDD skills!

## A word about tests and TDD

This section was written by [Marcelo](https://twitter.com/MarcVit). He used Project Euler to practice TDD with me, so he could practice it at his home too, and I'm pretty stoked with this wonderful insight (you can read it below).

When I started doing TDD, I thought it had a strong message. A simple set of rules that will automatically improve the design of your solution, make you better understand the relationship between your objects, promote loose coupling and, above all, **it will make you stay focused on what matters**.

It's really impressive how TDD proves its points real quick. The first image that came to mind when I thought about it was the "input - work - output" scenario that we see in programming. Generally, your code receives an input from the user or the system, it does something with that data, and it outputs or returns the result. TDD makes you concentrate on the part of your code that gets the job done, by enforcing an expected result, given a specific input.

Before writing any "production code" - or code that will actually solve your problem - you start by saying that, "When the input is X, I expect the result to be Y". The test will fail at start, but now you're free to work on the solution, exercising the code at every step you make towards the Green stage. When the test passes, you're done. Don't forget the refactoring step, though. As previously stated, you can't skip it.

Another thing that testing will do for you: **it will make you feel safe**. Imagine that you just arrived at a company, and your leader wants you to push code to production right away. Fortunately for you, the codebase has tests. By enforcing the constraints of the code, the test will assert that, given the input X, the result is Y.

Now, you feel comfortable to make any changes you want, since you can always run the test and see if it passes. If it fails, you can always go back to a state before that, and start over. A year from now, you'll be writing tests for a new functionality, and those tests will protect your code against your own mistakes - when changing it in the future - and against newcomers' mistakes, when getting their hands on it for the first time.

## Acknowledgments

I'd like to thank [Marcelo Vitoria](https://twitter.com/MarcVit) for his review and opinions that made this post readable, [Augusto Pascutti](https://twitter.com/augustohp) and [Eriksen Costa](https://twitter.com/eriksencp) for reviewing, feedback and references. Without they effort and precious time this post would not be possible.

## Finale

Don't wait for katas or dojos to try something new. Start by doing simple things and ask for feedback!

And if you want to try but have no idea how to start, please send me a message and I'll be pleased to help you out with your first problem/test!

Hope it helps!
