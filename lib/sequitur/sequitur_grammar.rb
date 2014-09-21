require_relative 'dynamic_grammar'


module Sequitur # Module for classes implementing the Sequitur algorithm

class SequiturGrammar < DynamicGrammar

  # Constructor. Build the grammar from an enumerator of tokens
  def initialize(anEnum)
    super()
    # Make start production compliant with utility rule
    2.times { root.incr_refcount }

    # Read the input sequence and apply the Sequitur algorithm
    anEnum.each do |a_token|
      add_token(a_token)
      enforce_rules
    end
  end

  public


CollisionDiagnosis = Struct.new(:collision_found, :digram, :productions)


  # Assuming that a new input token was added to the start production,
  # enforce the digram unicity and rule utility rules
  # begin
  #   if a digram D occurs twice in the grammar then
  #     add a production P : D (if not already there)
  #     replace both Ds with R (reduction step).
  #   end
  #   if a production P : RHS in referenced only once then
  #     replace P by its RHS (derivation step)
  #     remove P from grammar
  #   end
  #  end until digram unicity and rule utility are met
  def enforce_rules()
    begin
      unicity_diagnosis = detect_collision if unicity_diagnosis.nil?
      restore_unicity(unicity_diagnosis) if unicity_diagnosis.collision_found
      
      useless_prod = detect_useless_production
      restore_utility(useless_prod) if useless_prod

      unicity_diagnosis = detect_collision
      useless_prod = detect_useless_production
      
    end while unicity_diagnosis.collision_found || useless_prod
  end

  # Check whether a digram is used twice in the grammar.
  # Return an empty Hash if each digram appears once.
  # Otherwise return a Hash with a pair of the form: digram => [Pi, Pk]
  # Where Pi, Pk are two productions where the digram occurs.
  def detect_collision()
    diagnosis = CollisionDiagnosis.new(false)
    found_so_far = {}
    productions.each do |a_prod|
      prod_digrams = a_prod.digrams
      prod_digrams.each do |a_digr|
        its_key = a_digr.key
        if found_so_far.include? its_key
          orig_digr = found_so_far[its_key]
          # Disregard sequence like a a a 
          if ((orig_digr.production == a_prod) && a_digr.repeating? &&
            (orig_digr == a_digr))
            next
          end

          diagnosis.digram = orig_digr
          diagnosis.productions = [orig_digr.production, a_prod]
          diagnosis.collision_found = true
          break
        else
          found_so_far[its_key] = a_digr
        end
      end
      break if diagnosis.collision_found
    end

    return diagnosis
  end

  # When a collision diagnosis indicates that a given
  # digram d occurs twice in the grammar
  # Then create a new production that will have
  # the symbols of d as its rhs members.
  def restore_unicity(aDiagnosis)
    return if aDiagnosis.nil?

    digr = aDiagnosis.digram
    prods = aDiagnosis.productions
    if prods.any?(&:single_digram?)
      (simple, compound) = prods.partition do |a_prod|
        a_prod.single_digram?
      end
      compound[0].replace_digram(simple[0])
    else
      # Create a new production with the digram's symbols as its
      # sole rhs members.
      new_prod = Production.new
      digr.symbols.each { |sym| new_prod.append_symbol(sym) }
      add_production(new_prod)
      if prods[0] == prods[1]
        prods[0].replace_digram(new_prod)
      else
        prods.each { |a_prod| a_prod.replace_digram(new_prod) }
      end
    end
  end

  # Return a production that is used less than twice in the grammar.
  def detect_useless_production()
    useless = productions.find { |prod| prod.refcount < 2 }
    return (useless == productions[0]) ? nil : useless
  end

  # Given the passed production P is referenced only once.
  # Then replace P by its RHS where it is referenced.
  # And delete P
  def restore_utility(useless_prod)
    # Retrieve index of useless_prod
    index =  productions.index(useless_prod)

    # Retrieve production referencing useless one
    referencing = nil
    productions.each do |a_prod|
      # Next line assumes non-recursive productions
      next if a_prod == useless_prod

      refs = a_prod.references_of(useless_prod)
      next if refs.empty?
      referencing = a_prod
      break
    end

    referencing.replace_production(useless_prod)
    remove_production(index)
  end


end # class

end # module

# End of file
