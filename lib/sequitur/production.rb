require_relative 'digram'
require_relative 'production_ref'

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

  # The reference count (= how times other productions reference this one)
  attr_reader(:refcount)

  # The sequence of digrams appearing in the RHS
  attr_reader(:digrams)

  # Constructor. Build a production with an empty RHS.
  def initialize()
    clear_rhs
    @refcount = 0
    @digrams = []
  end

  public

  def ==(other)
    return true if object_id == other.object_id

    if other.is_a?(ProductionRef)
      result = (other == self)
    else
      result = false
    end

    return result
  end


  # Is the rhs empty?
  def empty?
    return rhs.empty?
  end

  def incr_refcount()
    @refcount += 1
  end

  def decr_refcount()
    fail StandardError, 'Internal error' if @refcount == 0
    @refcount -= 1
  end


  # Return the set of references to production appearing in the rhs.
  def references()
    return rhs.select { |symb| symb.is_a?(ProductionRef) }
  end

  # Return the set of references to a given production
  def references_of(aProduction)
    refs = references
    return refs.select { |a_ref| a_ref == aProduction }
  end


  # Return the list digrams found in rhs of this production.
  def recalc_digrams()
    return [] if rhs.size < 2

    result = []
    rhs.each_cons(2) { |couple| result << Digram.new(*couple, self) }

    @digrams = result
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
    result = digrams.empty? ? nil : digrams.last
    return result
  end



  # Emit a text representation of the production rule.
  # Text is of the form:
  # object id of production : rhs as space-separated sequence of symbols.
  def to_string()
    rhs_text = rhs.map do |elem|
      case elem
        when String then "'#{elem}'"
        else elem.to_s
      end
    end

    return "#{object_id} : #{rhs_text.join(' ')}."
  end

  # Add a (grammar) symbol at the end of the RHS.
  def append_symbol(aSymbol)
    case aSymbol
      when Production
        new_symb = ProductionRef.new(aSymbol)
      when ProductionRef
        if aSymbol.unbound?
          msg = 'Fail to append reference to nil production in '
          msg << to_string
          fail StandardError, msg
        end
        new_symb = aSymbol.dup
      else
        new_symb = aSymbol
    end

    rhs << new_symb
    digrams << Digram.new(rhs[-2], rhs[-1], self) if rhs.size >= 2
  end

  # Clear the right-hand side.
  # Any referenced production has its back reference counter decremented
  def clear_rhs()
    if rhs
      refs = references
      refs.each { |a_ref| a_ref.unbind }
    end
    @rhs = []
  end

  # Find all the positions where the digram occurs in the rhs
  # Synopsis:
  # Given the production p -> a b c a b a b d
  # Then p.positions_of(a, b) should returns [0, 3, 5]
  # Caution: "overlapping" digrams shouldn't be counted
  # Given the production p -> a a b a a a c d
  # Then p.positions_of(a, a) should returns [0, 3]
  def positions_of(symb1, symb2)

    # Find the positions where the digram occur in rhs
    indices = [ -2 ] # Dummy index!
    (0...rhs.size).each do |i|
      next if i == indices.last + 1
      indices << i if (rhs[i] == symb1) && (rhs[i + 1] == symb2)
    end

    indices.shift

    return indices
  end


  # Substitute in self all occurrences of the digram that
  # appears in the rhs of the other production
  # Pre-condition:
  # another has a rhs with exactly one digram (= a two-symbol sequence).
  def replace_digram(another)
    (symb1, symb2) = another.rhs
    pos = positions_of(symb1, symb2).reverse

    # Replace the two symbol sequence by the production
    pos.each do |index|
      if rhs[index].is_a?(ProductionRef)
        rhs[index].bind_to(another)
      else
        rhs[index] = ProductionRef.new(another)
      end
      index1 = index + 1
      rhs[index1].unbind if rhs[index1].is_a?(ProductionRef)
      rhs.delete_at(index1)
    end

    recalc_digrams
  end

  # Replace every occurrence of 'another' production in rhs by
  # the rhs of 'another'.
  # Given the production p_A -> a p_B b p_B c
  # And the production p_B -> x y
  # Then the call p_A.replace_production(p_B)
  # Modifies p_A as into:
  # p_A -> a x y b x y c
  def replace_production(another)
    (0...rhs.size).to_a.reverse.each do |index|
      next unless rhs[index] == another

      # Avoid the aliasing of production reference
      other_rhs = another.rhs.map do |symb|
        symb.is_a?(ProductionRef) ? symb.dup : symb
      end
      rhs.insert(index + 1, *other_rhs)
      another.decr_refcount
      rhs.delete_at(index)
    end

    recalc_digrams
  end


  # Part of the 'visitee' role.
  # [aVisitor] a GrammarVisitor instance
  def accept(aVisitor)
    aVisitor.start_visit_production(self)

    rhs.each do |a_symb|
      if a_symb.is_a?(ProductionRef)
        a_symb.accept(aVisitor)
      else
        aVisitor.visit_terminal(a_symb)
      end
    end

    aVisitor.end_visit_production(self)
  end

end # class

end # module

# End of file
