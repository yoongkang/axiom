require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction#optimize' do
  subject { disjunction.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'left and right are predicates' do
    let(:left)        { attribute.gt(1)                                 }
    let(:right)       { attribute.lt(3)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(disjunction) }
  end

  context 'left and right are negated predicates' do
    let(:disjunction) do
      Logic::Connective::Disjunction.new(
        Logic::Connective::Negation.new(attribute.gt(1)),
        Logic::Connective::Negation.new(attribute.lt(3))
      )
    end

    it { should_not equal(disjunction) }

    it 'reverses the operands' do
      should eql(Logic::Connective::Disjunction.new(attribute.lte(1), attribute.gte(3)))
    end
  end

  context 'left and right are the same' do
    let(:left)        { attribute.gt(1)                                 }
    let(:right)       { attribute.gt(1)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(left) }
  end

  context 'left and right are true propositions' do
    let(:left)        { Logic::Proposition::True.instance               }
    let(:right)       { Logic::Proposition::True.instance               }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(left) }
  end

  context 'left and right are false propositions' do
    let(:left)        { Logic::Proposition::False.instance              }
    let(:right)       { Logic::Proposition::False.instance              }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(left) }
  end

  context 'right is a true proposition' do
    let(:left)        { attribute.gt(1)                                 }
    let(:right)       { Logic::Proposition::True.instance               }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(right) }
  end

  context 'left is a true proposition' do
    let(:left)        { Logic::Proposition::True.instance               }
    let(:right)       { attribute.lt(3)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(left) }
  end

  context 'right is a false proposition' do
    let(:left)        { attribute.gt(1)                                 }
    let(:right)       { Logic::Proposition::False.instance              }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(left) }
  end

  context 'left is a false proposition' do
    let(:left)        { Logic::Proposition::False.instance              }
    let(:right)       { attribute.lt(3)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should equal(right) }
  end

  context 'left and right are equal predicates for the same attribute and different values' do
    let(:left)        { attribute.eq(1)                                 }
    let(:right)       { attribute.eq(3)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should eql(attribute.in([ 1, 3 ])) }
  end

  context 'left and right are equal predicates for the same attribute and the same values' do
    let(:left)        { attribute.eq(1)                                 }
    let(:right)       { attribute.eq(1)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should eql(attribute.eq(1)) }
  end

  context 'left and right are equal predicates for the same attribute, but left.right is an attribute' do
    let(:other)       { Attribute::Integer.new(:other_id)               }
    let(:left)        { attribute.eq(other)                             }
    let(:right)       { attribute.eq(1)                                 }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should eql(left | right) }
  end

  context 'left and right are equal predicates for the same attribute, but right.right is an attribute' do
    let(:other)       { Attribute::Integer.new(:other_id)               }
    let(:left)        { attribute.eq(1)                                 }
    let(:right)       { attribute.eq(other)                             }
    let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

    it { should eql(left | right) }
  end
end