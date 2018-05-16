### 0.1.19 / 2018-05-16
Maintenance release.
* [CHANGE] File `.travis.yml`: updated Ruby versions.
* [CHANGE] File `appveyor.yml` updated Ruby versions, updated for syntax changes.
* [CHANGE] File 'sequitur.gemspec' Updated versions in dependencies.
* [CHANGE] File 'Gemfile' Updated versions in dependencies.
* [CHANGE] File 'Gemfile' Code re-styling to please Rubocop 0.55.0.


### 0.1.18 / 2016-12-21
* [NEW] Added AppVeyor CI to Github commits. AppVeyor allows to build and test commits on Windows servers.
This is complementary to Travis CI which does Linux builds.
* [NEW] File `appveyor.yml` Contains the AppVeyor configuration.
* [CHANGE] File `README.md` Added AppVeyor badge.
* [CHANGE] File `.travis.yml`: updated Ruby versions to test for. Added MRI 2.3.x, dropped MRI 1.9.3
* [CHANGE] File 'sequitur.gemspec' Lowest supported Ruby version is now 2.0.0.
* [CHANGE] Many files. Code re-styling in order to please Rubocop 0.46.0


### 0.1.17 / 2015-09-05
* [CHANGE] File `.travis.yml`: Added versions MRI 2.2.0, JRuby 9.0.1.0

### 0.1.16 / 2015-09-05
* [CHANGE] Minor. Code re-formatted to please Rubocop 0.34.0
* [FIX] File `sequitur.gemspec`: updated gem version in development dependencies

### 0.1.15 / 2015-06-16
* [CHANGE] Code re-formatted to please Rubocop 0.32.0
* [FIX] File `.rubocop.yml`: change some cop settings.

### 0.1.14 / 2015-02-06
* [CHANGE] Code re-formatted to please Rubocop 0.29
* [FIX] File `.rubocop.yml`: removal of setting for obsolete EmptyLinesAroundBody cop.


### 0.1.13 / 2015-02-05
* [FIX] File `LICENSE.txt`: was missing in the distribution but was referenced in README.
* [CHANGE] File `README.md`: added badge from license (MIT).


### 0.1.12 / 2014-10-07
* [CHANGE] File `README.md`: Fixed documentation inaccuracy.


### 0.1.11 / 2014-10-07
* [CHANGE] File `README.md`: Added an example showing that Sequitur can work on a sequence of integers.
* [NEW] Folder `examples` Added a few code sample.

### 0.1.10 / 2014-10-05
* [CHANGE] Code refactoring for performance. Impacted classes: `SequiturGrammar`, `SymbolSequence` and `Production`.

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