module Toy
  module Querying
    extend ActiveSupport::Concern

    module ClassMethods
      def get(id)
        log_operation(:get, self, store, id)
        key = id_to_key(id)
        value = store.read(key)
        load(id,value)
      end

      def get!(id)
        get(id) || raise(Toy::NotFound.new(id))
      end

      def get_multi(*ids)
        ids.flatten.map { |id| get(id) }
      end

      def get_or_new(id)
        get(id) || new(:id => id)
      end

      def get_or_create(id)
        get(id) || create(:id => id)
      end

      def key?(id)
        log_operation(:key, self, store, id)
        store.key?(id)
      end
      alias :has_key? :key?

      def load(id, attrs)
        if key_factory.respond_to? :model_for_key
          instance = key_factory.model_for_key(id).allocate
        else
          instance = allocate
        end
        attrs && instance.initialize_from_database(attrs.update('id' => id))
      end
      
    end
  end
end