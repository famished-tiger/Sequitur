module Sequitur
  module Formatter
  
    # A formatter class that can render a dynamic grammar in plain text.
    # Synopsis:
    # some_grammar = ... # Points to a DynamicGrammar-like object
    # Output the result to the standard console output
    # formatter = Sequitur::Formatter::BaseText.new(STDOUT)
    # Render the grammar (through a visitor)
    # formatter.run(some_grammar.visitor)
    class BaseText
      attr(:output)

      # Constructor.
      # [anIO]
      def initialize(anIO)
        @output = anIO
        @prod_lookup = {}
      end

      public

      def render(aVisitor)
        aVisitor.subscribe(self)
        aVisitor.start()
        aVisitor.unsubscribe(self)
      end
      
      def before_grammar(aGrammar)
        aGrammar.productions.each_with_index do |a_prod, index|
          prod_lookup[a_prod] = index
        end
      end

      def before_production(aProduction)
        p_name = prod_name(aProduction)
        output.print p_name
      end

      def before_rhs(_)
        output.print ' :'
      end

      def before_terminal(aSymbol)
        output.print " #{aSymbol}"
      end


      def before_non_terminal(aProduction)
        p_name = prod_name(aProduction)
        output.print " #{p_name}"
      end

      def after_production(_)
        output.print ".\n"
      end

      private
      
      def prod_lookup()
        return @prod_lookup
      end
      
      def prod_name(aProduction)
        prod_index = prod_lookup[aProduction]
        name = (prod_index == 0) ? 'start' : "P_#{prod_index}"
        return name
      end

    end # class
  end # module
end # module

# End of file
