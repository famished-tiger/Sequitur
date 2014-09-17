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
- Rule (start) tells that the input consists of the sequence of P_1 P_2 P_3 patterns followed by the letter e.  
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



### TODO: Add more documentation ###


Copyright
---------
Copyright (c) 2014, Dimitri Geshef. Sequitur is released under the MIT License see [LICENSE.txt](https://github.com/famished-tiger/Sequitur/blob/master/LICENSE.txt) for details.