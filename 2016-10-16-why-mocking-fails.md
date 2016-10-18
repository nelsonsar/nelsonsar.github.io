# Why mocking fails?

[Yegor arguments that fake objects are better than mocks](http://www.yegor256.com/2014/09/23/built-in-fake-objects.html) shows that mocks can be really hard to build when objects create another objects and these another objects create more objects and so on (maybe forever?) and I agree with it (this is the beginning of a **mock hell**).

But, the whole point is: should we create all these mocks returning mocks? Or should we rely on the fake objects the post suggests?

## The great virtue of OOP

[John Cinnamond](https://twitter.com/jcinnamond) in a recent [talk](http://brightonruby.com/2016/the-point-of-objects-john-cinnamond/) makes a brilliant conclusion about OOP: it's a tool used to desconstruct a complex problem and defer decisions (implementations). By using it you (your team, your company, whatever) can focus in one problem at a time.

More than a tool, OOP bundles data and bevahior so you can create (or stabilish using domain rules) your own truth ([invariants](https://en.wikipedia.org/wiki/Class_invariant)) and define protocols (contracts, [interfaces](https://pragprog.com/book/kpiod/interface-oriented-design) to provide interactions between objects, teams and clients (customers) and, tests are the way we document and validate our protocols but, it really shines when you need to defer decisions.

## Mocks as defer tools

When you're writing a test (even more when you do TDD) mocks can replace complex interactions (yeah, those that OOP enables) or inexistent collaborators so you don't need to care about the details of how things are done. I'll use the same example Yegor used:

```ruby
require 'spec_helper'
  
describe Employee do
  describe '#salary' do
    it 'return amount based on employee region' do
      region = double
      expect(region).to receive(:salary_by)
                        .with('Nelson').and_return(5000)
      employee = Employee.new('Nelson', region)
      
      expect(employee.salary).to eq(5000)
    end
  end
end
```

In the example above you don't have any idea of what `region` actually is or how it gets the salary information, I just describe how the interaction occurs.

For me the reason to use mocks is: represent the interaction between objects while [programming for an interface not for an implementation](http://www.artima.com/lejava/articles/designprinciples.html).

Programming to an interface enables the replacement of the `region` dependency with anything that responds to the `salary_by` message (I can even create a fake class, to hide `region` implementation, using a `Hash` for example) and defer the decision of which ORM, database or library I'd like to use to another team or just do it later.

## You can only defer what you can control

But, in order to enable mocks hidden powers (or make them shine) you need to control them and that's where mocks always goes wrong...

The [Mock Roles, not Objects paper](http://www.jmock.org/oopsla2004.pdf) stabilish a set of simple rules (ok, not rules... guidelines) for mocks and the most important one (and ignored most of the time too), IMO, is: "Only Mock Types You Own". Following this simple guideline you'll **always** have to mock an interface created by you, which is most of the time simpler than the one exposed by a library (because of the level of abstraction it needs).

**Simpler interfaces == easier to test and mantain** (less public methods, less coupling and higher cohesion).

So, if you find yourself creating a mock that returns other mock or mocking a third party library think twice, be sure that the operation shouldn't be better encapsulated (maybe is a missing domain aspect in your app, for example) and don't be afraid of changing it if you think a mock hell is knocking at your door (or can emerge soon).

Happy testing!
