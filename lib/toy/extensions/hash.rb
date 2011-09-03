module Toy
  module Extensions
    module Hash
      def store_default
        {}
      end
      
      def to_store(value, attribute)
        value.to_json
      end
      
      def from_store(value, attribute)
        case value.class
        when Hash
          value
        when String
          ActiveSupport::JSON.decode(value)
        when NilClass
          store_default
        else
          raise "wtf is a #{value.class}"
        end
      end

    end
  end
end

class Hash
  extend Toy::Extensions::Hash
end