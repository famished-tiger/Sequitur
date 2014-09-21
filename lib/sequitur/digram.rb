# File: digram.rb

module Sequitur # Module for classes implementing the Sequitur algorithm

# In linguistics, a digram is a sequence of two letters.
# In Sequitur a digram is a sequence of two consecutive symbols that
# appear in a grammar (production) rule. Each symbol in a digram 
# can be a terminal or not.
class Digram
  # The sequence of two consecutive grammar symbols.
  attr_reader(:symbols)
  
  # An unique Hash key of the digram
  attr_reader(:key)
  
  # The production in which the digram occurs
  attr_reader(:production)
  
  # Constructor.
  # @param symbol1 [StringOrSymbol] First element of the digram
  # @param symbol2 [StringOrSymbol] Second element of the digram
  # @param aProduction [Production] Production in which the RHS 
  # the sequence symbol1 symbol2 appears.
  def initialize(symbol1, symbol2, aProduction)
    @symbols = [symbol1, symbol2]
    @key = "#{symbol1.hash.to_s(16)}:#{symbol2.hash.to_s(16)}" 
    @production = aProduction
  end
  
  # Equality testing.
  # Returns true when keys of both digrams are equal
  def ==(other)
    return key == other.key
  end
  
  # Return true when the digram consists of twice the same symbols
  def repeating?()
    return symbols[0] == symbols[1]
  end
  
end # class

end # module

# End of file
