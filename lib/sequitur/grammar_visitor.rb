module Sequitur # Module for classes implementing the Sequitur algorithm

# A visitor class dedicated in the visit of Grammar.

class GrammarVisitor
  attr_reader(:grammar)
  
  attr_reader(:subscribers)
  
  # Constructor.
  # [aGrammar] a DynamicGrammar-like instance.
  def initialize(aGrammar)
    @grammar = aGrammar
    @subscribers = []
  end
  
  public
  
  # Add a subscriber to the list.
  def subscribe(aSubscriber)
    subscribers << aSubscriber
  end
  
  def unsubscribe(aSubscriber)
    subscribers.delete_if { |entry| entry == aSubscriber }
  end
  
  # The signal to start the visit.
  def start()
    grammar.send(:accept, self)
  end

  
  def start_visit_grammar(aGrammar)
    broadcast(:before_grammar, aGrammar)
  end
  

  def start_visit_production(aProduction)
    broadcast(:before_production, aProduction)
    broadcast(:before_rhs, aProduction.rhs)
  end


  def visit_prod_ref(aProdRef)
    production = aProdRef.production
    broadcast(:before_non_terminal, production)
    broadcast(:after_non_terminal, production)
  end

  def visit_terminal(aTerminal)
    broadcast(:before_terminal, aTerminal)
    broadcast(:after_terminal, aTerminal)
  end 


  def end_visit_production(aProduction)
    broadcast(:after_rhs, aProduction.rhs)
    broadcast(:after_production, aProduction)

  end  
  
  
  def end_visit_grammar(aGrammar)
    broadcast(:after_grammar, aGrammar)
  end
  
  private

  def broadcast(msg, *args)
    subscribers.each do |a_subscriber|
      next unless a_subscriber.respond_to?(msg)
      a_subscriber.send(msg, *args)
    end
  end
  
  
end # class

end # module

# End of file
