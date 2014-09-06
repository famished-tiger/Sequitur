

module Sequitur # Module for classes implementing the Sequitur algorithm

# A production reference is a grammar symbol that may appear in the right-hand
# side of a production P1 and that refers to a production P2.
# Every time a production P2 appears in the left-hand side of
# production P1, this is implemented by inserting a production reference to P2
# in the appropriate position in the RHS of P1.
# In the literature, production references are also called non terminal
# symbols
class ProductionRef

  # Link to the production to reference
  attr_reader(:production)

  # Constructor
  # [target] The production that is being referenced.
  def initialize(target)
    bind_to(target)
  end
  
  # Copy constructor invoked by dup or clone methods
  def initialize_copy(orig)
    @production = nil
    bind_to(orig.production)
  end

  # Return the text representation of a production reference.
  def to_s()
    return "#{production.object_id}"
  end

  alias_method :to_string, :to_s


  # Equality testing.
  # A production ref is equal to another one when its
  # refers to the same production or when it is compared to
  # the production it refers to.
  def ==(other)
    return true if object_id == other.object_id

    if other.is_a?(ProductionRef)
      result = (production == other.production)
    else
      result = (production == other)
    end

    return result
  end

  # Generates a Fixnum value as hash value.
  # As a reference has no identity on its own,
  # the method returns the hash value of the
  # referenced production
  def hash()
    fail StandardError, 'Nil production' if production.nil?
    return production.hash
  end
  
  # Make this reference points to the given production
  def bind_to(aProduction)
    return if aProduction == @production
    
    production.decr_refcount if production
    unless aProduction.kind_of?(Production)
      fail StandardError, "Illegal production type #{aProduction.class}"
    end
    @production = aProduction  
    production.incr_refcount
  end

  # Clear the reference to the target production
  def unbind()
    production.decr_refcount
    @production = nil
  end

  # Check that the this object doesn't refer to any production.
  def unbound?()
    return production.nil?
  end

end # class

end # module

# End of file
