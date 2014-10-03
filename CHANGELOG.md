### 0.1.09 / 2014-10-03
* [NEW] Class `SymbolSequence`. Part of code refactoring that reduces code complexity reported by CodeClimate.
* [CHANGE] Class `Production` refactored to use a SymbolSequence instance as its rhs.
* [CHANGE] File `README.md`: Minor cosmetic enhancements.

### 0.1.08 / 2014-09-30
* [CHANGE] Method `SequiturGrammar#restore_unicity` Code refactored to reduce code complexity reported by CodeClimate.
* [CHANGE] File `README.md`: Minor cosmetic enhancements.

### 0.1.07 / 2014-09-29
* [CHANGE] File `README.md`: Fixed bad Markdown syntax in badge part.

### 0.1.06 / 2014-09-29
* [NEW] New file `.coveralls.yml` Coveralls configured to use Travis CI
* [CHANGE] File `README.md`: added badge from coveralls (test coverage).
* [CHANGE] Files `Gemfile`, `sequitur.gemspec`: added development dependency on coveralls gem.
* [CHANGE] File `spec_helper.rb` Added Coveralls customization code


### 0.1.05 / 2014-09-28
* [CHANGE] File `README.md`: added badge from inch-ci.org (documentation quality).

### 0.1.04 / 2014-09-28
* [CHANGE] All methods are now documented (YARD reports 100% coverage).

### 0.1.03 / 2014-09-21
* [CHANGE] Class `Sequitur::SequiturGrammar` Code refactoring: cleaner and simpler implementation the algorithm.
* [CHANGE] Class `Sequitur::Digram`. Added new method `repeating?` that tells whether digram members are the same.

### 0.1.02 / 2014-09-18
* [CHANGE] File `README.md`: expanded introductory text.
* [CHANGE] File `sequitur.gemspec` : expanded gem description in the specification.

### 0.1.01 / 2014-09-17
* [NEW] Added new `BaseFormatter` superclass. Sample formatters are inheriting from this one.  
* [CHANGE] File `README.md`: added a brief intro to the Sequitur algorithm, expanded the Ruby examples 
* [CHANGE] Private method `BaseText#prod_name` production name doesn't contain an underscore.
* [CHANGE] Formatter class `BaseText` now inherits from `BaseFormatter`
* [CHANGE] Formatter class `Debug` now inherits from `BaseFormatter`


### 0.1.00 / 2014-09-16
* [CHANGE] Version number bumped. Added grammar rendering through specialized formatters.


### 0.0.14 / 2014-09-10
* [CHANGE] Removal of invariant checking methods in `SequiturGrammar` class. These caused polynomial slowdown.


### 0.0.13 / 2014-09-07
* [CHANGE] Test coverage for all classes but SequiturGrammar is 100%

### 0.0.12 / 2014-09-06
* [CHANGE] Significant internal refactoring.
* [CHANGE] Method `ObjectSpace::id2ref` is no more used => one obstacle to JRuby porting is removed.
* [NEW] Added new class `ProductionReference`

### 0.0.11 / 2014-08-26
* [FIX] `SequiturGrammar#check_unicity`: an exception was raised when it shouldn't. Added example in spec file.
* [CHANGE] `sequitur.rb` : Added the convenience Sequitur::build_from method.

### 0.0.10 / 2014-08-25
* [CHANGE] `README.md`: Added hyperlinks about Sequitur algorithm.

### 0.0.09 / 2014-08-24
* [FIX] `sequitur.rb`: require still referred to old file name.

### 0.0.08 / 2014-08-24
* [CHANGE] `production_spec.rb`: Improved tests in order to reach 100% code coverage for the Production class.

### 0.0.07 / 2014-08-24
* [CHANGE] `digram.rb`: Updated Digram class documentation.

### 0.0.06 / 2014-08-24
* [CHANGE] `.rubocop.yml`: Enabled FileName cop and updated source file names accordingly.

### 0.0.05 / 2014-08-24
* [CHANGE] `README.md`: added badge for Rubygems

### 0.0.04 / 2014-08-24
* [FIX] `.travis.yml`: removed JRuby from Travis CI. Rationale: ObjectSpace class is disabled!

### 0.0.03 / 2014-08-24
* [FIX] `Rakefile`: removed unused Cucumber-based task

### 0.0.02 / 2014-08-24
* [CHANGE] `README.md`: added badge from Travis CI

### 0.0.01 / 2014-08-24

* [FEATURE] Initial public working version