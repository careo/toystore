module Toy
  module Extensions
    module Array
      def store_default
        []
      end

      def to_store(value, attribute)
        value = value.respond_to?(:lines) ? value.lines : value
        value.to_json
      end

      def from_store(value, attribute)
        case value.class
        when Array
          value
        when String
          ActiveSupport::JSON.decode(value)
        when NilClass
          store_default
        else
          raise "wtf"
        end
      end

    end
  end
end

class Array
  extend Toy::Extensions::Array
end