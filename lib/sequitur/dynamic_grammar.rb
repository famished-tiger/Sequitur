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
    puts('Removed: ' + prod.to_string) if trace
    prod.clear_rhs

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


  # Check that every production reference in rhs is
  # pointing to a production of the grammar
  def check_rhs_of(aProduction)
    aProduction.references.each do |symb|
      referenced_prod = symb.production
      next if productions.include?(referenced_prod)

      msg = "Production #{aProduction.object_id} refers to"
      msg << " production #{referenced_prod.object_id}"
      msg << ' that is not part of the grammar.'
      fail StandardError, msg
    end
  end

end # class

end # module

# End of file
