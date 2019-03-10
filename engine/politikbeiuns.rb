module Onebox
  module Engine
    module PolitikbeiunsOnebox

      def self.included(object)
        object.extend(ClassMethods)
      end

      module ClassMethods
        def matches_entity(entity)
          class_variable_set :@@entity, entity
          matches_regexp(/^(?:https?:\/\/)?(?:www\.)?politik-bei-uns\.de\/#{Regexp.escape(entity)}\/(?<pid>[a-fA-F0-9]{24})\S*$/)
        end
      end

    end
  end
end
