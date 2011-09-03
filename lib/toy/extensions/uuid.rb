module Toy
  module Extensions
    module UUID

      def to_store(value, attribute)
        if value
          new(value).bytes
        else
          nil
        end
      end

      def from_store(value, attribute)
        new(value).to_guid
      end

    end
  end
end

class SimpleUUID::UUID
  extend Toy::Extensions::UUID
end
