module PDC::Resource
  module Associations
    class HasOne < Association
      def initialize(*args)
        super
        @options.reverse_merge!(uri: "#{parent.class.model_name.plural}/:#{foreign_key}/#{@name}")
        collect_params
      end

      def collect_params
        p_mapping = parent.class.mapping
        s_foreign_key = foreign_key.to_s
        if s_foreign_key.include? '/'
          s_foreign_key.split('/').each do |fk|
            p_mapping_value = p_mapping[fk.to_sym]
            @params[fk] =
              if p_mapping && p_mapping_value
                parent.attributes[p_mapping_value.to_sym]
              else
                parent.attributes[fk]
              end
          end
        else
          @params[foreign_key] = parent.id
        end
      end
    end
  end
end
