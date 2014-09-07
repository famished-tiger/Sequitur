### 0.0.13 / 2014-08-24
* [CHANGE] Test coverage for all classes but SequiturGrammar is 100%

### 0.0.12 / 2014-08-24
* [CHANGE] Significant internal refactoring.
* [CHANGE] Method `ObjectSpace::id2ref` is no more used => one obstacle to JRuby porting is removed.
* [NEW] Added new class `ProductionReference`

### 0.0.11 / 2014-08-24
* [FIX] `SequiturGrammar#check_unicity`: an exception was raised when it shouldn't. Added example in spec file.
* [CHANGE] `sequitur.rb` : Added the convenience Sequitur::build_from method.

### 0.0.10 / 2014-08-24
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