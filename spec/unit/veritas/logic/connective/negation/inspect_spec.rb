require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#inspect' do
  subject { negation.inspect }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  it { should == "NOT(#{operand.inspect})" }
end