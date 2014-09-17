module Sequitur
  module Formatter
  
    # Superclass for grammar formatters.
    class BaseFormatter
      # The IO output stream in which the formatter's result will be sent.
      attr(:output)

      # Constructor.
      # [anIO] an output IO where the formatter's result will be placed.
      def initialize(anIO)
        @output = anIO
      end

      public
      
      # Given a grammar or a grammar visitor, perform the visit
      # and render the visit events in the output stream.
      def render(aGrmOrVisitor)
        aVisitor = if aGrmOrVisitor.kind_of?(GrammarVisitor)
          aGrmOrVisitor
        else
          aGrmOrVisitor.visitor
        end
        
        aVisitor.subscribe(self)
        aVisitor.start()
        aVisitor.unsubscribe(self)
      end
    
    end # class
  end # module
end # module