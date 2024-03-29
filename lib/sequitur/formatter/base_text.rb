# frozen_string_literal: true

require_relative 'base_formatter'

module Sequitur
  module Formatter
    # A formatter class that can render a dynamic grammar in plain text.
    # @example
    #   some_grammar = ... # Points to a DynamicGrammar-like object
    #   # Output the result to the standard console output
    #   formatter = Sequitur::Formatter::BaseText.new(STDOUT)
    #   # Render the grammar (through a visitor)
    #   formatter.run(some_grammar.visitor)
    class BaseText < BaseFormatter
      # @return [Hash{Production => Integer}]
      attr_reader :prod_lookup

      # Constructor.
      # @param anIO [IO] The output stream to which the rendered grammar
      # is written.
      def initialize(anIO)
        super(anIO)
        @prod_lookup = {}
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor is about to visit a grammar
      # @param aGrammar [DynamicGrammar]
      def before_grammar(aGrammar)
        aGrammar.productions.each_with_index do |a_prod, index|
          prod_lookup[a_prod] = index
        end
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor is about to visit
      # a production
      # @param aProduction [Production]
      def before_production(aProduction)
        p_name = prod_name(aProduction)
        output.print p_name
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor is about to visit
      # the rhs of a production
      # @param _ [Array]
      def before_rhs(_)
        output.print ' :'
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor is about to visit
      # a terminal symbol from the rhs of a production
      # @param aSymbol [Object]
      def before_terminal(aSymbol)
        output.print " #{aSymbol}"
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor is about to visit
      # a non-terminal (= an allusion to a production) in the rhs of a
      # production
      # @param aProduction [Production] a production occurring in the rhs
      def before_non_terminal(aProduction)
        p_name = prod_name(aProduction)
        output.print " #{p_name}"
      end

      # Method called by a GrammarVisitor to which the formatter subscribed.
      # Notification of a visit event: the visitor complete the visit
      # of a production
      # @param _ [Production]
      def after_production(_)
        output.print ".\n"
      end

      private

      # Generate a name of a given production.
      # @param aProduction [Production]
      # @return [String]
      def prod_name(aProduction)
        prod_index = prod_lookup[aProduction]
        prod_index.zero? ? 'start' : "P#{prod_index}"
      end
    end # class
  end # module
end # module

# End of file
