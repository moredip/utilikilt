<style type="text/css">
div.figure {
	border: 1px dotted;
	padding-left: 1em;
	padding-right: 1em;
}

div.figure img {
	border:0px;
}
</style>

#Working with Indirect Input and Output in Unit Testing


##Testing how a unit of code interacts with its environment

When testing a unit of code you need to both observe how the unit of code is interacting with the outside world and also control how the world interacts with it. 

In a particuarly simple example, you might want to check that when an adder function is given a 2 and a 4 then it returns a 6. In this case you're controlling what the **System Under Test** (SUT) pulls in from its environment (the 2 and the 4) and also observing what it pushes out (the 6). In a more sophisticated example you might be testing a method which talks to a remote service, verifying that if it receives an error code when trying to read from the network then it logs the appropriate error message to a logger. Note that we're still doing essentially the same thing here - controlling what the SUT pulls in from the environment (an error code in this case) and observing what it pushes out (a call to a logger in this case).

These two examples both illustrate the same fundamental practice of controlling input and observing output, but they are dealing with different kinds of input and output. In the first example of the adder function we are controlling the [Direct Input](http://xunitpatterns.com/direct%20input.html) provided to the SUT, and observing the [Direct Output](http://xunitpatterns.com/direct%20output.html). In the second example we are controlling [Indirect Input](http://xunitpatterns.com/indirect%20input.html) and observing [Indirect Output](http://xunitpatterns.com/indirect%20output.html) (these terms are courtesy of the quite great [XUnit Test Patterns book](http://xunitpatterns.com)).

<div class="figure">
<img src="input_output_diagram.png"></img>
</div>

As you can see, direct input and output is so called because it is provided directly to the SUT by the unit test. On the other hand, Indirect Input and Output can only be controlled and observed *indirectly*, via the SUT's **dependencies** (aka [Depended Upon Components](http://xunitpatterns.com/DOC.html)). In one of the previous examples we were testing some code which needed to talk to a remote service. In that case the SUT would have had a dependency on some sort of lower level network service. We used this dependency to inject Indirect Input in the form of an error code being returned when the network service was called. Our SUT also had a dependency on some sort of logging service. We used *that* dependency to observe Indirect Output by checking that a logging method was called with the logging information we expect in the circumstances we simulated using the Indirect Input of an error coming back from the network service.

## How do we manage indirect input and output? 

We control indirect input and measure indirect output within our Unit Tests by using [Test Doubles](http://www.martinfowler.com/bliki/TestDouble.html). This term encompasses the test-specific doohickeys commonly referred to as **Mocks** and **Stubs**, as well as the more esoteric variants such as **Spies**, **Dummies**, **Fakes**, etc. 

In my personal opinion the vocabulary for these things is pretty confusing, and the definitions do not appear to be universally agreed upon and consistent. Also, I don't often find myself too concerned with the implementation-specific differences which for some definitions serve to distinguish between e.g. a Stub vs a Mock. To me a much more important distinction is in what *role* a specific Test Double is playing in the test at hand. Is it helping to inject Indirect Input, or is it helping to observe Indirect Output? Or is it simply there to replace a required dependency for which we don't want to use a real implementation? In an ill-advised mixing of terminology, I categorize these roles as Mocking, Stubbing, or Faking. I know this aligns quite poorly with other definitions for these terms, but they're the best I have for now. 

## Test Double Roles

### Stubbing 
This refers to using a Test Double to control your SUT by providing specific Indirect Input. For example, you might supply your SUT with a testing-specific implementation of a Car repository which you have pre-configured to return a specific Car instance. This Car instance would be the indirect input which you are providing to your SUT. Another classic example would be injecting a fake Clock into your SUT so that you can test how it behaves at 1 second before midnight, or on February 29, or on [December 21 2012](http://en.wikipedia.org/wiki/2012_phenomenon).

### Mocking
This refers to using a Test Double to observe some piece of Indirect Output produced by your SUT. Perhaps you're creating a system that lets people tweet messages to the Jumbotron at a baseball game, and you need to make sure that you filter the tweets for naughty words. You could supply your SUT with a mock implementation of a RudeWordFilter class, and check that its filtering methods are being called correctly.

### Faking
A Faking Test Double is one which is just being used to satisfy the SUT's dependencies, and which is *not* being used to provide Indirect Input or to observe Indirect Output. Maybe the method you're testing writes entries to a logger as it goes about its business. Your *current* test doesn't care about this behavior, so you provide a [Null Object](http://en.wikipedia.org/wiki/Null_Object_pattern) implementation of the Logger to the SUT. This Null logger will simply ignore any logging methods which are called on it. Note that I emphasized that the *current* test wasn't interested in how the SUT uses the logger. Other tests likely would be, and in those tests the Test Double which provides the Logger dependency would likely play a Mocking role rather than a Faking role.

## Test Double Roles vs Test Double Implementation
It's important to note here that the way in which these Test Doubles are implemented is orthogonal to the role they are playing. You can use a 'mocking framework' (e.g. Mockito, JMock, Typemock, EasyMock) both to supply Indirect Input and to observe Indirect Output. On the other hand you could just as well use hand-written classes (sometimes referred to as stubs) to achieve both these goals. This orthogonality between the technique you're using to create your Test Doubles and the role a Test Double is playing is an important but subtle point, and is part of why I'm really not happy with the confusing terminology I have been using.

## Acknowledgements
Lots of the ideas in this post are inspired by the patterns in the wonderful, encyclopedic XUnit Test Patterns book. It's not exactly a 5 minute read, but never the less I highly recommend it. Most of the patterns in the book are also covered in very high-level overview form on the accompanying website, [xunitpatterns.com](http://xunitpatterns.com).

I *think* my categorization of the Mocking, Stubbing and Faking roles lines up pretty closely with what Roy Osherove describes in his book, [The art of unit testing](), but I haven't read the book so I can't say that with any confidence.
