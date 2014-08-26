Sequitur
===========
_Ruby gem implementing the Sequitur algorithm_  
[Homepage](https://github.com/famished-tiger/Sequitur)  

[![Build Status](https://travis-ci.org/famished-tiger/Sequitur.svg?branch=master)](https://travis-ci.org/famished-tiger/Sequitur)
[![Gem Version](https://badge.fury.io/rb/sequitur.svg)](http://badge.fury.io/rb/sequitur)


### What is the Sequitur algorithm? ###
[Sequitur home](http://sequitur.info/)  
[Wikipedia](http://en.wikipedia.org/wiki/Sequitur_algorithm)  

Sequitur is an algorithm that generates a set of rules representing a sequence of input tokens.  
It detects repeated token patterns and can represent them in a compact way.


## Synopsis  

```ruby  

    require 'sequitur' # Load the Sequitur library

    input_sequence =  'abcabdab'

    # The SEQUITUR algorithm will detect the repeated 'ab' pattern
    # and will generate a context-free grammar that represents the input string
    grammar = Sequitur.build_from(input_sequence)

    # Display the grammar rules
    # Each rule is displayed with the format:
    # rule_id : a_sequence_grammar_symbols
    # Where: 
    # - rule_id is the object id of a rule (in decimal)
    # - a grammar symbol is either a terminal symbol 
    # (i.e. a character from the input) or the id of a production
    puts grammar.to_string
```

### TODO: Add more documentation ###


Copyright
---------
Copyright (c) 2014, Dimitri Geshef. Sequitur is released under the MIT License see [LICENSE.txt](https://github.com/famished-tiger/Sequitur/blob/master/LICENSE.txt) for details.