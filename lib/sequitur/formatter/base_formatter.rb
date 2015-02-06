module Sequitur
  # Namespace dedicated to grammar formatters.
  module Formatter
    # Superclass for grammar formatters.
    class BaseFormatter
      # The IO output stream in which the formatter's result will be sent.
      attr(:output)

      # Constructor.
      # @param anIO [IO] an output IO where the formatter's result will
      # be placed.
      def initialize(anIO)
        @output = anIO
      end

      public

      # Given a grammar or a grammar visitor, perform the visit
      # and render the visit events in the output stream.
      # @param aGrmOrVisitor [DynamicGrammar or GrammarVisitor]
      def render(aGrmOrVisitor)
        if aGrmOrVisitor.kind_of?(GrammarVisitor)
          a_visitor = aGrmOrVisitor
        else
          a_visitor = aGrmOrVisitor.visitor
        end

        a_visitor.subscribe(self)
        a_visitor.start
        a_visitor.unsubscribe(self)
      end
    end # class
  end # module
end # module

# End of file
