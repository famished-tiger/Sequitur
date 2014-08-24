require_relative 'digram'

module Sequitur # Module for classes implementing the Sequitur algorithm


# In a context-free grammar, a production is a rule in which
# its left-hand side (LHS) consists solely of a non-terminal symbol
# and the right-hand side (RHS) consists of a sequence of symbols.
# The symbols in RHS can be either terminal or non-terminal symbols.
# The rule stipulates that the LHS is equivalent to the RHS,
# in other words every occurrence of the LHS can be substituted to
# corresponding RHS.
# The object id of the production is taken as its LHS.
class Production
  # The right-hand side (rhs) consists of a sequence of grammar symbols
  attr_reader(:rhs)

  # A Hash with pairs of the form:
  # production id => reference count
  # Where the reference count is the number of times this production
  # appears in the rhs of the production with given id.
  attr_reader(:backrefs)

  # Constructor. Build a production with an empty RHS.
  def initialize()
    clear_rhs
    @backrefs = {}
  end

  public

  # Is the rhs empty?
  def empty?
    return rhs.empty?
  end


  # Return the set of productions appearing in the rhs.
  def references()
    return rhs.select { |symb| symb.kind_of?(Production) }
  end


  # Does the rhs have exactly one digram only (= 2 symbols)?
  def single_digram?
    return rhs.size == 2
  end


  # Detect whether the last digram occurs twice
  # Assumption: when a digram occurs twice in a production then it must occur
  # at the end of the rhs
  def repeated_digram?
    return false if rhs.size < 3

    my_digrams = digrams
    all_keys = my_digrams.map(&:key)
    last_key = all_keys.pop
    same_key_found = all_keys.index(last_key)
    return !same_key_found.nil?
  end
  
  # Return the last digram appearing in the RHS.
  def last_digram()
    return nil if rhs.size < 2
    
    return Digram.new(rhs[-2], rhs[-1], self)
  end



  # The back reference count is the number of times this production
  # appears in the rhs of all the productions of the grammar
  def refcount()
    total = backrefs.values.reduce(0) do |sub_result, count|
      sub_result += count
    end

    return total
  end

  # Add a back reference to the given production.
  # @param aProduction [Production] Assume that production P appears in the 
  #   RHS of production Q, then a reference count of P is incremented in Q.
  def add_backref(aProduction)
    prod_id = aProduction.object_id

    count = backrefs.fetch(prod_id, 0)
    backrefs[prod_id] = count + 1
    return count
  end

  # Decrement the reference count for the given production.
  # If result is zero, then the entry is removed from the Hash.
  def remove_backref(aProduction)
    prod_id = aProduction.object_id

    count = backrefs.fetch(prod_id)
    fail StandardError if count < 1

    if count > 1
      backrefs[prod_id] = count - 1
    else
      backrefs.delete(prod_id)
    end

    return count
  end

  # Emit a text representation of the production rule.
  # Text is of the form:
  # object id of production : rhs as space-separated sequence of symbols.
  def to_string()
    rhs_text = rhs.map do |elem|
      case elem
        when String then "'#{elem}'"
        when Production then "#{elem.object_id}"
      else elem.to_s
      end
    end

    return "#{object_id} : #{rhs_text.join(' ')}."
  end

  # Return the digrams for this production as if
  # the given symbol is appended at the end of the rhs
  def calc_append_symbol(aSymbol)
    return [] if empty?

    return digrams + [ Digram.new(rhs.last, aSymbol, self) ]
  end

  def append_symbol(aSymbol)
    aSymbol.add_backref(self) if aSymbol.kind_of?(Production)
    rhs << aSymbol
  end

  # Clear the right-hand side.
  # Any referenced production has its back reference counter decremented
  def clear_rhs()
    if rhs
      refs = references
      refs.each { |a_ref| a_ref.remove_backref(self) }
    end
    @rhs = []
  end

  # Return the list digrams found in rhs of this production.
  def digrams()
    return [] if rhs.size < 2

    result = []
    rhs.each_cons(2) { |couple| result << Digram.new(*couple, self) }

    return result
  end

  # Substitute in self all occurence of the digram that
  # appears in the rhs of the other production
  # Pre-condition:
  # another has a rhs with exactly one digram (= a two-symbol sequence).
  def replace_digram(another)
    # Find the positions where the digram occur in rhs
    (symb1, symb2) = another.rhs
    indices = [ -2 ] # Dummy index!

    (0...rhs.size).each do |i|
      next if i == indices.last + 1
      indices << i if (rhs[i] == symb1) && (rhs[i + 1] == symb2)
    end
    indices.shift

    pos = indices.reverse

    # Replace the two symbol sequence by the production
    pos.each do |index|
      rhs[index].remove_backref(self) if rhs[index].kind_of?(Production)
      rhs[index] = another
      index1 = index + 1
      rhs[index1].remove_backref(self) if rhs[index1].kind_of?(Production)
      rhs.delete_at(index1)
      another.add_backref(self)
    end
  end

  # Replace every occurrence of 'another' production in rhs by
  # the rhs of 'another'.
  def replace_production(another)
    (0...rhs.size).to_a.reverse.each do |index|
      next unless rhs[index] == another
      rhs.insert(index + 1, *another.rhs)
      another.rhs.each do |new_symb|
        new_symb.add_backref(self) if new_symb.kind_of?(Production)
      end
      another.remove_backref(self)
      rhs.delete_at(index)
    end
  end

end # class

end # module

# End of file
