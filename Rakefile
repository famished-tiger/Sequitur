# frozen_string_literal: true

require 'rubygems'
require_relative './lib/sequitur/constants'

namespace :gem do
  desc 'Push the gem to rubygems.org'
  task :push do
    system("gem push sequitur-#{Sequitur::Version}.gem")
  end
end # namespace

# Testing-specific tasks

# RSpec as testing tool
require 'rspec/core/rake_task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

# Run RSpec tests
desc 'Run tests, with RSpec'
task test: [:spec]

# Default rake task
task default: :test

# End of file
