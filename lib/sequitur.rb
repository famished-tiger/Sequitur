# File: sequitur.rb
# This file acts as a jumping-off point for loading dependencies expected
# for a Sequitur client.

require_relative './sequitur/constants'
require_relative './sequitur/sequitur_grammar'


module Sequitur

  # Convenience method. Builds a Sequitur-generated grammar based
  # on the sequence of input tokens
  # @param tokens [StringOrEnumerator] The input sequence of input tokens.
  # Can be a sequence of characters (i.e. a String) or an Enumerator
  # Tokens returned by enumerator should respond to the :hash message.
  # Returns a SequiturGrammar instance.
  def self.build_from(tokens)
    input_sequence = case tokens
      when String then tokens.chars
      when Enumerator then tokens
      else tokens.to_enum
    end
    
    return SequiturGrammar.new(input_sequence)
  end
end # module

# End of file
