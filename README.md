Sequitur
===========
_Ruby gem implementing the Sequitur algorithm_  
[Homepage](https://github.com/famished-tiger/Sequitur)  

[![Build Status](https://travis-ci.org/famished-tiger/Sequitur.svg?branch=master)](https://travis-ci.org/famished-tiger/Sequitur)
[![Gem Version](https://badge.fury.io/rb/sequitur.svg)](http://badge.fury.io/rb/sequitur)
[![Dependency Status](https://gemnasium.com/famished-tiger/Sequitur.png)](https://gemnasium.com/famished-tiger/Sequitur)


### What is the Sequitur algorithm? ###
The following are good entry points to learn about the algorithm:  
[Sequitur algorithm home](http://sequitur.info/)  
[Wikipedia](http://en.wikipedia.org/wiki/Sequitur_algorithm)  

### The theory in a nutshell ###
Given a sequence of input tokens (say, characters), the Sequitur algorithm 
will represent that input sequence as a set of rules. As the algorithm detects 
automatically repeated token patterns, the resulting rule set can encode repetitions in the input
in a very compact way.  
Of interest is the fact that the algorithm runs in time linear in the length of the input sequence.

**Can you give a simple example?**  
Sure. Let's begin with a very basic case. Assume that 'abcabcabc' is our input string.
Notice that it is the same as the text 'abc' repeated three times. The Sequitur algorithm captures
this repetition and will generate the two following rules:

```
start : P1 P1 P1.  
P1 : a b c.
```

In plain English:
-The first rule (named start) always represents the whole input. Here, it indicates that the input
is three time the pattern encoded by the rule called P1.
-The second rule (named P1) represents the sequence a b c.

**Can you give another example?**  
Yep. Assume this time that the input is 'ababcabcdabcde'. 
Then Sequitur algorithm will generate the rule set:  
```
start : P1 P2 P3 P3 e.  
P1 : a b.  
P2 : P1 c.  
P3 : P2 d.   
```

Translated in plain English:  
- Rule (start) tells that the input consists of the sequence of P1 P2 P3 patterns followed by the letter e.  
- Rule (P1) represents the sequence 'ab'.  
- Rule (P2) represents the pattern encoded by P1 (thus 'ab') then 'c'.   
In other words, it represents the string 'abc'.  
- Rule (P3) represents the pattern encoded by P2 then d. It is thus equivalent to 'abcd'.  

**What is it used for?**  
Sequitur can be used:  
- As a lossless data compression algorithm (especially for structured text containing
repeated elements)  
- To detect hierarchical structure in sequences (e.g. traces in program execution)


## Synopsis  

**Time for a quick demo**

The following Ruby snippet show how to apply Sequitur on the input string from the last example above. 

```ruby  

    require 'sequitur'  # Load the Sequitur library

    input_sequence =  'ababcabcdabcde'  # Let's analyze this string

    # Run the Sequitur algorithm which will result in a grammar (=rule set)
    grammar = Sequitur.build_from(input_sequence)
````

The demo illustrates how easy it is to run the algorithm on a string. However, the next question is how
can you make good use of the algorithm's result.  

**Printing the resulting rules**  
The very first natural step is to be able to print out the (grammar) rules.
Here's how:
 

```ruby  
    require 'sequitur'
    input_sequence =  'ababcabcdabcde'
    grammar = Sequitur.build_from(input_sequence)

    # To display the grammar rules on the console output
    # We use a grammar formatter
    formatter = Sequitur::Formatter::BaseText.new(STDOUT)

    # Now render the rules. Each rule is displayed with the format:
    # rule_id : a_sequence_grammar_symbols.
    # Where: 
    # - rule_id is either 'start' or a name like 'Pxxxx' (xxxx is a sequential number)
    # - a grammar symbol is either a terminal symbol 
    # (i.e. a character from the input) or a rule id
    formatter.render(grammar.visitor)

    # Rendered output is:
    # start : P1 P2 P3 P3 e.
    # P1 : a b.
    # P2 : P1 c.
    # P3 : P2 d.
```

## Understanding the algorithm's results
The Sequitur algorithm generates a -simplified- context-free grammar, therefore we dedicate this section
to the terminology about context-free grammars. As the Internet provides tons of information can be found
on the subject, we limit ourselves to the minimal terminology of interest when using the sequitur gem.
 
First of all, what is a **grammar**? To simplify the matter, one can see a grammar as a set of
grammar rules. These rules are called production rules or more briefly **productions**.  

In a context-free grammar, productions have the form:  
````
P : body.
```

Where:
- The colon ':' character separates the head (= left-hand side) and the body (right-hand side, *rhs* in short)
of the rule.
- The left-hand side consists just of one symbol, P. P is a categorized as a *nonterminal symbol* and for our purposes 
a nonterminal symbol can be seen as the "name" of the production. By contrast, a terminal symbol is just one element 
from the input sequence (symbols as defined in formal grammar theory shouldn't be confused with Ruby's `Symbol` class). 
- the body is a sequence -possibly empty- of *symbols* (terminal or nonterminal). 

Basically, a production rule tells that P is equivalent to the sequence of symbols found in the 
right-hand side of the production. A nonterminal symbol that appears in the rhs of a production can be
seen as a reference to the production with same name.


## The Sequitur API

Recall the above example: a single call to the `Sequitur#build_from` factory method
suffices to construct a grammar object.

```ruby  
    require 'sequitur'

    input_sequence =  'ababcabcdabcde'
    grammar = Sequitur.build_from(input_sequence)
```

The return value `grammar` is a `Sequitur::SequiturGrammar` instance.

Unsurprisingly, the `Sequitur::SequiturGrammar` class defines an accessor method called 'productions'
that returns the productions of the grammar as an array of `Sequitur::Production` objects.

```ruby
	# Count the number of productions in the grammar
	puts grammar.productions.size # => 4

	# Retrieve all productions of the grammar
	all_prods = grammar.productions
	
	# Retrieve the start production
	start_prod = grammar.production[0]
```

Once we have a grip on a production, it is easy to access its right-hand side through the `Production#rhs` method.
It returns an array of symbols.

```ruby
	# ...Continuing the same example
	# Retrieve the right-hand side of the production
	prod_body = start_prod.rhs	# Return an Array object
```

The RHS of a production is a sequence (i.e. Array) of symbols.
How are the grammar symbols implemented?
-Terminal symbols are directly originating from the input sequence. They are inserted "as is" in the
RHS. For instance, if the input sequence consists of integer values (i.e. Finum instances), then they
will be inserted in the RHS of productions.
-Non-terminal symbols are implemented as `Sequitur::ProductionRef` objects.

A ProductionRef is reference to a Production object. The latter one can be accessed through the `ProductionRef#production` method.


### Installation ###
The sequitur gem installation is fairly standard.  
If your project has a `Gemfile` file, add `sequitur` to it. Otherwise, install the gem like this:
 
```bash  
$[sudo] gem install sequitur
```



### TODO: Add more documentation ###


Copyright
---------
Copyright (c) 2014, Dimitri Geshef. Sequitur is released under the MIT License see [LICENSE.txt](https://github.com/famished-tiger/Sequitur/blob/master/LICENSE.txt) for details.