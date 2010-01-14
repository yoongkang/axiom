module Veritas
  class Relation
    module Operation
      class Offset < Relation
        include Unary

        def self.new(relation, offset)
          unless relation.body.kind_of?(Order::Body)
            raise ArgumentError, 'can only slice a relation with an ordered body'
          end

          super
        end

        def initialize(relation, offset)
          @offset = offset
          super(relation)
        end

        def to_int
          @offset
        end

        def body
          @body ||= Relation::Body.new(relation.body.drop(to_int), header)
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
