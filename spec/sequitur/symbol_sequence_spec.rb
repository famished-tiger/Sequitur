require_relative '../spec_helper'

# Load the class under test
require_relative '../../lib/sequitur/symbol_sequence'
require_relative '../../lib/sequitur/production_ref'
require_relative '../../lib/sequitur/production'

module Sequitur # Re-open the module to get rid of qualified names

describe SymbolSequence do

  let(:instance) { SymbolSequence.new } 

  context 'Creation and initialization:' do

    it 'should be created without argument' do
      expect { SymbolSequence.new }.not_to raise_error
    end

    it 'should be empty at creation' do
      expect(subject).to be_empty
    end

  end # context

  context 'Provided services:' do
    subject do
      an_instance = SymbolSequence.new
      [:a, :b, :c].each { |a_sym| an_instance << a_sym }
      an_instance
    end
    
    it 'should deep-copy clone itself' do
      a_prod = Production.new
      ref = ProductionRef.new(a_prod)
      
      a,  c = 'a', 'c'
      [a, ref, c].each { |ch| instance << ch }
      clone_a = instance.clone
      
      # Check that cloning works
      expect(clone_a).to eq(instance)
      
      # Reference objects are distinct but points to same production
      expect(clone_a.symbols[1].object_id).not_to eq(instance.symbols[1])
      
      # Modifying the clone...
      clone_a.symbols[1] = 'diff'
      expect(clone_a).not_to eq(instance)
      
      # ... should leave original unchanged
      expect(instance.symbols[1]).to eq(ref)
    end
    

    it 'should tell that it is equal to itself' do
      # Case: Non-empty sequence
      expect(subject).to eq(subject)

      # Case: empty sequence
      expect(instance).to eq(instance)
    end

    it 'should know whether it is equal to another instance' do
      expect(instance).to eq(instance)

      expect(subject).not_to eq(instance)
      [:a, :b, :c].each { |a_sym| instance << a_sym }      
      expect(subject).to eq(instance)
      
      # Check that element order is relevant
      instance.symbols.rotate!
      expect(subject).not_to eq(instance)      
    end
    
    it 'should know whether it is equal to an array' do
      expect(subject).to eq([:a, :b, :c])
      
      # Check that element order is relevant
      expect(subject).not_to eq([:c, :b, :a])   
    end
    
    it 'should know that is not equal to something else' do
      expect(subject).not_to eq(:abc)
    end

  end # context



end # describe

end # module

# End of file