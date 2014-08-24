require_relative 'production'

module Sequitur # Module for classes implementing the Sequitur algorithm

class DynamicGrammar
  # Link to the root - start - production.
  attr_reader(:root)

  # The set of production rules of the grammar
  attr_reader(:productions)
  
  # nodoc Trace the execution of the algorithm.
  attr(:trace, true)


  # Constructor.
  # Build a grammar with one empty rule as start/root rule
  def initialize()
    @root = Production.new
    @productions = [ root ]
    @trace = false
  end

  public

  # Emit a text representation of the grammar.
  # Each production rule is emitted per line.
  def to_string()
    rule_text = productions.map(&:to_string).join("\n")
    return rule_text
  end


  # Add a production to the grammar.
  def add_production(aProduction)
    # TODO: remove output
    puts "Adding #{aProduction.object_id}" if trace
    puts aProduction.to_string if trace
    check_rhs_of(aProduction) # TODO: configurable check
    productions << aProduction
  end


  # Remove a production from the grammar
  def delete_production(anIndex)
    puts "Before production removal #{productions[anIndex].object_id}" if trace
    puts to_string if trace
    prod = productions.delete_at(anIndex)
    # TODO: remove output
    puts prod.to_string if trace
    prod.clear_rhs

    check_backrefs  # TODO: configurable check

    return prod
  end


  # Add the given token to the grammar.
  def add_token(aToken)
    append_symbol_to(root, aToken)
  end

  protected

  def append_symbol_to(aProduction, aSymbol)
    aProduction.append_symbol(aSymbol)
  end


  # Check that any production reference in rhs is
  # pointing to a production of the grammar
  def check_rhs_of(aProduction)
    aProduction.references.each do |symb|
      next if productions.include?(symb)

      msg = "Production #{aProduction.object_id} refers to "
      msg << "production #{symb.object_id}"
      msg << ' that is not part of the grammar.'
      fail StandardError, msg
    end
  end

  # Check the invariants:
  # Every back reference must must point to a production of the grammar
  # Every back reference count must be equal to the number
  # of occurrences in the referencing production.
  def check_backrefs()
    return if productions.size < 2

    all_but_root = productions[1...productions.size]
    all_but_root.each do |a_prod|
      a_prod.backrefs.each do |other_prod_id, count|
        begin
          other_prod = ObjectSpace._id2ref(other_prod_id)
        rescue RangeError => exc
          msg = "Production #{a_prod.object_id} has a backref to "
          msg << "recycled production #{other_prod_id}."
          msg << "\n#{to_string}"
          $stderr.puts msg
          raise exc
        end
        found = productions.find { |elem| elem == other_prod }
        unless found
          msg = "Production #{a_prod.object_id} is referenced by the "
          msg << "unknown production (#{other_prod_id})."
          msg << "\n#{to_string}"
          fail StandardError, msg
        end

        unless count == found.rhs.count { |symb| symb == a_prod }
          msg = "Production #{a_prod.object_id} has a count mismatch"
          msg << "\nIt expects #{count} references in rhs of #{other_prod_id} "
          msg << "but actual count is #{other_prod.rhs.count}."
          msg << "\n#{to_string}"
          fail StandardError, msg
        end
      end
    end
  end

end # class

end # module

# End of file
