class ApplicationController < ActionController::API
    include Knock::Authenticable

    module Knock::Authenticable
        def define_current_entity_getter entity_class, getter_name
          unless self.respond_to?(getter_name)
            memoization_var_name = "@_#{getter_name}"
            self.class.send(:define_method, getter_name) do
              unless instance_variable_defined?(memoization_var_name)
                current =
                  begin
                    Knock::AuthToken.new(token: token).entity_for(entity_class)
                  rescue => e
                    throw e
                    #nil
                  end
                instance_variable_set(memoization_var_name, current)
              end
              instance_variable_get(memoization_var_name)
            end
          end
        end
      end
end
