---
layout: default
title: "What is an object?"
---

## Motivation

OOP is my favorite programming paradigm (I don't know functional programming so maybe I just ran out of options). And yet it's older than me. Heck, people say that it's even older than my dad! But I feel that I (and a lot of people in the wild) don't apply it right on daily basis.

With the raise (rediscover) of the functional paradigm lots of people on the internet are saying that OOP is dead or useless and **my** guess is: people suffer from the same problem (that I also suffer from), they never **learned** the basics...

Since I always wanted to make a basic tour thru OOP, here is my first post about it.

## Definition of an object

The whole idea of an object is to represent something or, as defined in Simula language: *"simulate some aspect of reality"*. And with it we can create dogs, bicycles and even represent people! But, as in the real world, not everything is equal: dogs have different color, weight and height and the same goes for the other two examples, these **properties** are called **state**.

### State

Since animals examples are bad let's use another one to explain things. From now on I will borrow [Mathias Verraes invoice example](http://verraes.net/2014/09/objects-as-contracts-for-behaviour/).

An invoice has some nice properties (or attributes): amount, issuer, who paid and a flag if it's paid or not. These attributes define how **I** see (in a very simplistic way) an invoice, they characterize an object as an invoice (here for a [better definition](http://www.investopedia.com/terms/i/invoice.asp)).

As Grady Booch said:

*"The state of an object encompasses all of the (usually static) properties of the object plus the current (usually dynamic) values of each of these properties."*

By static he meant that since these attributes define the object they shouldn't change, since they are fundamental to the existence of the object (and also to distinguish it).

The values of these attributes help to tell the story of the object:

"I need to pay Bestbuy for my $300 computer invoice"

The above statement says that the following invoice object was created:

```
invoice::amount = 300
invoice::paid = false
invoice::issuer = Bestbuy
invoice::buyer = Me
```

And I could do the reverse way just by seeing the attributes of another invoice object. It's very important to note that the values of the attributes may be another object or just scalar values.

That said I need to pay this invoice, and "as a buyer, I want to be able to pay my invoice" said an user story. To complete this requirement we need more than state in our object: it needs the ability of changing its own data and collaborate with other objects (that also need to change its own data... recursion...).

### Behavior

Behavior is what an object can do and how it communicates its responsibilities to the outside world. Typically we call these responsibilities methods, and the combination of them with state define the protocol that clients need to know to use the services of a given object.

To make things clear, let's use our invoice example: if a invoice was paid we cannot pay it again, right? So the object **must** signal it, by returning an error code, a special case object or throwing an exception.

Below, an example of an invoice class with behavior and also rules that define its protocol (or what clients needs to be aware of):

```
class Invoice
  def pay(amount)
    # Rules for payment here, for example:
    # 1) If the invoice is already paid throw an exception
    # 2) If the given amount is not enough, throw an exception
    #    or change the state of the invoice to "balance due"
    # 3) If everything is ok, change the state of this invoice
    #    to paid to prevent it been paid twice
  end

  def amount
    # returns the amount that needs to be paid
  end

  def paid?
    # returns if the invoice was paid
  end

  def issuer_name
    # returns the issuer name
  end

  # ...and so on
end
```

So we can quote Grady Booch again:

*"The state of an object represents the cumulative results of its behavior."*

If we could create a stack of called methods (and all of them could be undone) we could restore the initial state but also create a log of all modifications done in the given object (to audit a given state in a point in time). That's how reactive programming is done and, yeah, we can do it with OOP basics.

### Identity

Identity gives us the ability of creating multiple objects with same the state and behavior. It's a fundamental concept of OOP because this avoids that changing one instance, while letting others instances unchanged. Let's go back to our invoice example: Due its simplicity it's pretty reasonable that two different instances have the same properties, but I still can pay just one of them.

## Conclusion

These concepts are fundamental to truly understand OOP and create OOP based systems. Without them we may break one of the four OOP pillars (most of the time leading to breaking encapsulation). Next time I'll talk about what is not an object, see you there!

## Acknowledgements

This post wouldn't be possible without the help of [Augusto](https://twitter.com/augustohp), [Marcelo](https://twitter.com/MarcVit) and Rafael a.k.a Cabelo (does not have a Twitter account, shame on him).

## References

Most of this writing is based in what is described [here](https://www.amazon.com/Object-Oriented-Analysis-Design-Applications-3rd/dp/020189551X).

* [Mathias Verraes' article](http://verraes.net/2014/09/objects-as-contracts-for-behaviour/)

