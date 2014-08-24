require_relative '../spec_helper'

# Load the class under test
require_relative '../../lib/sequitur/digram'

module Sequitur # Re-open the module to get rid of qualified names

describe Digram do
  let(:two_symbols) { [:b, :c] }

  context 'Standard creation & initialization:' do
  
    it 'should be created with 3 arguments' do
      production = double('sample-production')
      instance = Digram.new(:b, :c, production)
      
      expect(instance.symbols).to eq(two_symbols)
      expect(instance.production_id).to eq(production.object_id)
    end
    
    it 'should return the production that it refers to' do
      production = double('sample-production')
      instance = Digram.new(:b, :c, production)
      expect(instance.production).to eq(production)
    end

  end # context 

end # describe

end # module

# End of file
