require 'pdc/resource/associations/association'

module PDC::Resource
  module Associations
    class HasMany < Association
      def initialize(*args)
        super
        @options.reverse_merge!(uri: "#{parent_path}/:#{foreign_key}/#{@name}/(:#{primary_key})")
        @params[foreign_key] = parent.id
      end

      def load
        self
      end

      private

      def parent_path
        parent.class.model_name.element.pluralize
      end
    end
  end
end
