# frozen_string_literal: true

class Query
  MODEL = nil

  class << self
    def model
      self::MODEL if const_defined?('MODEL', false)
    end

    def inherited(child)
      child.extend(MetaMethods)
    end

    module MetaMethods
      def method_missing(method_name, ...)
        if extended_relation.respond_to?(method_name)
          extended_relation.public_send(method_name, ...)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_all = false)
        super || extended_relation.respond_to?(method_name, include_all)
      end
    end

    private

    def base_relation
      model_class.all
    end

    def scopes
      model ? self::Scopes : [self::Scopes, superclass::Scopes]
    end

    def model_class
      self::MODEL
    end

    def extended_relation(relation = nil)
      (relation || base_relation).extending(scopes)
    end
  end

  module Scopes
    ### Add ActiveRelation methods here
  end
end
