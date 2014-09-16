Sequitur
===========
_Ruby gem implementing the Sequitur algorithm_  
[Homepage](https://github.com/famished-tiger/Sequitur)  

[![Build Status](https://travis-ci.org/famished-tiger/Sequitur.svg?branch=master)](https://travis-ci.org/famished-tiger/Sequitur)
[![Gem Version](https://badge.fury.io/rb/sequitur.svg)](http://badge.fury.io/rb/sequitur)
[![Dependency Status](https://gemnasium.com/famished-tiger/Sequitur.png)](https://gemnasium.com/famished-tiger/Sequitur)


### What is the Sequitur algorithm? ###
[Sequitur home](http://sequitur.info/)  
[Wikipedia](http://en.wikipedia.org/wiki/Sequitur_algorithm)  

Sequitur is an algorithm that generates a set of rules representing a sequence of input tokens.  
It detects repeated token patterns and can represent them in a compact way.


## Synopsis  

```ruby  

    require 'sequitur'  # Load the Sequitur library

    input_sequence =  'abcabdabcabd'  # Let's analyze this string

    # The SEQUITUR algorithm will detect the repeated 'ab' pattern
    # and will generate a context-free grammar that represents the input string
    grammar = Sequitur.build_from(input_sequence)

    # To display the grammar rules on the console output
    # We use a formatter
    formatter = Sequitur::Formatter::BaseText.new(STDOUT)

    # Now render the rules. Each rule is displayed with the format:
    # rule_id : a_sequence_grammar_symbols.
    # Where: 
    # - rule_id is either 'start' or a name like 'P_xxxx' (xxxx is a sequential number)
    # - a grammar symbol is either a terminal symbol 
    # (i.e. a character from the input) or a rule id
    formatter.render(grammar.visitor)

    # Rendered output is:
    # start : P_2 P_2.
    # P_1 : a b.
    # P_2 : P_1 c P_1 d.
```

### TODO: Add more documentation ###


Copyright
---------
Copyright (c) 2014, Dimitri Geshef. Sequitur is released under the MIT License see [LICENSE.txt](https://github.com/famished-tiger/Sequitur/blob/master/LICENSE.txt) for details.