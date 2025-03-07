# frozen_string_literal: true

# File: constants.rb
# Purpose: definition of Sequitur constants.

# Module used as a namespace for Sequitur classes
module Sequitur
  # rubocop:disable Naming/ConstantName

  # @return [String] The version number of the gem.
  Version = '0.1.26'

  # @return [String] Brief description of the gem.
  Description = 'Ruby implementation of the Sequitur algorithm'

  # Constant Sequitur::RootDir contains the absolute path of Sequitur's
  # start directory. Note: it also ends with a slash character.
  unless defined?(RootDir)
    # The initialisation of constant RootDir is guarded in order
    # to avoid multiple initialisation (not allowed for constants)

    # @return [String] The start folder of Sequitur.
    RootDir = begin
      require 'pathname' # Load Pathname class from standard library
      startdir = Pathname(__FILE__).dirname.parent.parent.expand_path
      "#{startdir}/" # Append trailing slash character to it
    end
  end
  # rubocop:enable Naming/ConstantName
end # module

# End of file
