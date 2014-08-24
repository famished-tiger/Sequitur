module Sequitur # Module for classes implementing the Sequitur algorithm

# A digram is a sequence of two grammar symbols (terminal or not).
class Digram
  # The sequence of two consecutive grammar symbols.
  attr_reader(:symbols)
  
  # The object id of the production that contains this digram in its rhs.
  attr_reader(:production_id)
  
  # An unique Hash key of the digram
  attr_reader(:key)
  
  # Constructor.
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
