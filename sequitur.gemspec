# encoding: utf-8
# File: sequitur.gemspec
# Gem specification file for the Sequitur project.

require 'rubygems'

# The next line generates an error with Bundler
require_relative './lib/sequitur/constants'


SEQUITUR_GEMSPEC = Gem::Specification.new do |pkg|
  pkg.name = 'sequitur'
  pkg.version = Sequitur::Version
  pkg.author = 'Dimitri Geshef'
  pkg.email = 'famished.tiger@yahoo.com'
  pkg.homepage = 'https://github.com/famished-tiger/Sequitur'
  pkg.platform = Gem::Platform::RUBY
  pkg.summary = Sequitur::Description
  pkg.description = 'Ruby implementation of the Sequitur algorithm.'
  pkg.post_install_message = <<EOSTRING
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thank you for installing Sequitur...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EOSTRING
  pkg.rdoc_options << '--charset=UTF-8 --exclude="examples|features|spec"'
  file_list = Dir[
    '.rubocop.yml', '.rspec', '.ruby-gemset', '.ruby-version', '.simplecov',
    '.travis.yml',  '.yardopts', 'cucumber.yml', 'Gemfile', 'Rakefile',
    'CHANGELOG.md',
    'LICENSE.txt', 'README.md',
    'lib/*.*', 'lib/**/*.rb',
    'spec/**/*.rb'
  ]
  pkg.files = file_list
  pkg.test_files = Dir[ 'spec/**/*_spec.rb' ]

  pkg.require_path = 'lib'

  pkg.extra_rdoc_files = ['README.md']

  pkg.add_development_dependency('rake', ['>= 0.8.0'])
  pkg.add_development_dependency('rspec', ['>= 3.0.0'])
  pkg.add_development_dependency('simplecov', ['>= 0.5.0'])
  pkg.add_development_dependency('rubygems', ['>= 2.0.0'])

  # pkg.bindir = 'bin'
  # pkg.executables = %w(sequitur)
  pkg.license = 'MIT'
  pkg.required_ruby_version = '>= 1.9.1'
end

if $PROGRAM_NAME == __FILE__
  require 'rubygems/package'
  Gem::Package.build(SEQUITUR_GEMSPEC)
end

# End of file
