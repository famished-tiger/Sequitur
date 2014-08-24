require_relative '../spec_helper'

# Load the class under test
require_relative '../../lib/sequitur/dynamic_grammar'

module Sequitur # Re-open the module to get rid of qualified names

describe DynamicGrammar do
  # Factory method. Build a production with the given sequence
  # of symbols as its rhs.
  def build_production(*symbols)
    prod = Production.new
    symbols.each { |symb| prod.append_symbol(symb) }
    return prod
  end

  let(:p_a) { build_production(:a) }
  let(:p_b) { build_production(:b) }
  let(:p_c) { build_production(:c) }
  let(:p_bc) { build_production(p_b, p_c) }


  context 'Creation & initialization:' do

    it 'should be created without parameter' do
      expect { DynamicGrammar.new }.not_to raise_error
    end

    it 'should have an empty root/start production' do
      expect(subject.root).to be_empty
      expect(subject.productions.size).to eq(1)
      expect(subject.productions.first).to be_empty
    end

  end # context


  context 'Adding productions to the grammar:' do
    it 'should add a simple production' do
      subject.add_production(p_a)
      expect(subject.productions.size).to eq(2)
      expect(subject.productions.last).to eq(p_a)
      
      # Error: p_b, p_c not in grammar
      expect { add_production(p_bc) }.to raise_error(StandardError)

      subject.add_production(p_b)
      expect(subject.productions.size).to eq(3)
      expect(subject.productions.last).to eq(p_b)

      # Error: p_c not in grammar      
      expect { add_production(p_bc) }.to raise_error(StandardError)

      subject.add_production(p_c)
      expect(subject.productions.size).to eq(4)
      expect(subject.productions.last).to eq(p_c)
      
      subject.add_production(p_bc)
      expect(subject.productions.size).to eq(5)
      expect(subject.productions.last).to eq(p_bc) 
    end
    
    it 'should complain when rhs refers to unknown production' do
      subject.add_production(p_a)
      subject.add_production(p_b)
      # Test fails because of Production#references
      msg = "Production #{p_bc.object_id} refers to production #{p_c.object_id}"
      msg << ' that is not part of the grammar.'
      expect { subject.add_production(p_bc) }.to raise_error(StandardError, msg)
      
    end
  end # context

  
  context 'Removing a production from the grammar:' do
    it 'should remove an existing production' do
      subject.add_production(p_a) # index = 1
      subject.add_production(p_b) # index = 2
      subject.add_production(p_c) # index = 3
      subject.add_production(p_bc) # index = 4
      expect(subject.productions.size).to eq(5)
      
      expect(p_a.refcount).to eq(0)
      expect(p_b.refcount).to eq(1)
      expect(p_c.refcount).to eq(1)
      
      subject.delete_production(1)  # 1 => p_a
      expect(subject.productions.size).to eq(4)
      expect(p_b.refcount).to eq(1)
      expect(p_c.refcount).to eq(1)
      expect(subject.productions).not_to include(p_a)
      
      subject.delete_production(3) # 3 => p_bc
      
      expect(subject.productions.size).to eq(3)
      expect(p_b.refcount).to eq(0)
      expect(p_c.refcount).to eq(0) 
      expect(subject.productions).not_to include(p_bc)      
    end
    
  end # context


  context 'Generating a text representation of itself:' do

    it 'should generate a text representation when empty' do
      expectation = "#{subject.root.object_id} : ."
      expect(subject.to_string).to eq(expectation)
    end

    # it 'should generate a text representation of a simple production' do
    #   instance = SequiturGrammar.new([:a].to_enum)
    #   expectation = "#{instance.root.object_id} : a."
    #   expect(instance.to_string).to eq(expectation)
    # end

  end # context

end # describe

end # module

# End of file
