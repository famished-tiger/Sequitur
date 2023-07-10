# frozen_string_literal: true

# Demo of sequitur gem: from a set of sentences, generate a context-free grammar

require 'engtagger'
require 'sequitur'

# Simple sentences taken from the first lesson of "Learn These Words First".
# ( https://learnthesewordsfirst.com/  )
sentences = <<~END_TEXT
  Tony sees Lisa.
  Tony sees something.
  Lisa sees something.
  Tony sees this thing.
  Lisa sees the other thing.
END_TEXT

tagger = EngTagger.new
pairs = tagger.tag_pairs(sentences)
tag_sequence = pairs.map(&:last)

# Generate the grammar from the tag sequence
grammar = Sequitur.build_from(tag_sequence)

# Use a formatter to display the grammar rules on the console output
formatter = Sequitur::Formatter::BaseText.new($stdout)

# Now render the rules
formatter.render(grammar.visitor)
# Rendered output is:
# start : P1 nnp P2 P2 P4 nn P4 jj nn pp.
#   P1 : nnp vbz.
#   P2 : P3 nn.
#   P3 : pp P1.
#   P4 : P3 det.
