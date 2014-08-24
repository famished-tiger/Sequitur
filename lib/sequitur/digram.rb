# File: digram.rb

module Sequitur # Module for classes implementing the Sequitur algorithm

# In linguitics, a digram is a sequence of two letters.
# In Sequitur a digram is a sequence of two consecutive symbols that
# appear in a grammar (production) rule. Each symbol in a digram 
# can be a terminal or not.
class Digram
  # The sequence of two consecutive grammar symbols.
  attr_reader(:symbols)
  
  # The object id of the production that contains this digram in its rhs.
  attr_reader(:production_id)
  
  # An unique Hash key of the digram
  attr_reader(:key)
  
  # Constructor.
  # @param symbol1 [StringOrSymbol] First element of the digram
  # @param symbol2 [StringOrSymbol] Second element of the digram
  # @param aProduction [Production] Production in which the RHS 
  # the sequence symbol1 symbol2 appears.
  def initialize(symbol1, symbol2, aProduction)
    @symbols = [symbol1, symbol2]
    @key = "#{symbol1.hash.to_s(16)}:#{symbol2.hash.to_s(16)}" 
    @production_id = aProduction.object_id
  end

  # Return the production object of this digram
  def production()
    ObjectSpace._id2ref(production_id)
  end
end # class

end # module

# End of file
