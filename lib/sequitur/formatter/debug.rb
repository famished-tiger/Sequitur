module Sequitur
  module Formatter
    class Debug
      attr(:indentation)
      attr(:output)

      # Constructor.
      # [anIO]
      def initialize(anIO)
        @indentation = 0
        @output = anIO
      end

      public

      def render(aVisitor)
        aVisitor.subscribe(self)
        aVisitor.start()
        aVisitor.unsubscribe(self)
      end

      def before_grammar(_)
        output_event(__method__, indentation)
        indent
      end

      def before_production(_)
        output_event(__method__, indentation)
        indent
      end

      def before_rhs(_)
        output_event(__method__, indentation)
        indent
      end

      def before_terminal(_)
        output_event(__method__, indentation)
      end

      def after_terminal(_)
        output_event(__method__, indentation)
      end

      def before_non_terminal(_)
        output_event(__method__, indentation)
      end

      def after_non_terminal(_)
        output_event(__method__, indentation)
      end

      def after_rhs(_)
        dedent
        output_event(__method__, indentation)
      end

      def after_production(_)
        dedent
        output_event(__method__, indentation)
      end

      def after_grammar(_)
        dedent
        output_event(__method__, indentation)
      end

      private

      def indent()
        @indentation += 1
      end

      def dedent()
        @indentation -= 1
      end

      def output_event(anEvent, indentationLevel)
        output.puts "#{' ' * 2 * indentationLevel}#{anEvent}"
      end

    end # class
  end # module
end # module

# End of file
