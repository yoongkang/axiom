require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Conjunction#inspect' do
  subject { conjunction.inspect }

  let(:attribute)   { Attribute::Integer.new(:id)                     }
  let(:left)        { attribute.gt(1)                                 }
  let(:right)       { attribute.lt(3)                                 }
  let(:conjunction) { Logic::Connective::Conjunction.new(left, right) }

  it { should == "(#{left.inspect} AND #{right.inspect})"}
end