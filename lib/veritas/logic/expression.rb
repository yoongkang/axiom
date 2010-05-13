module Veritas
  module Logic
    class Expression
      include AbstractClass, Optimizable

      def self.eval(*)
        raise NotImplementedError, "#{name}.eval must be implemented"
      end

      def project(attributes)
        self
      end

      def rename(aliases)
        self
      end

      def ==(other)
        optimize.eql?(other.optimize)
      end

      def eql?(other)
        raise NotImplementedError, "#{self.class.name}#eql? must be implemented"
      end

      def hash
        raise NotImplementedError, "#{self.class.name}#hash must be implemented"
      end

      def inspect
        raise NotImplementedError, "#{self.class.name}#inspect must be implemented"
      end

    end # class Expression
  end # module Logic
end # module Veritas