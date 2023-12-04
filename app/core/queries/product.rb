# frozen_string_literal: true

module Queries
  class Product < ::Query
    MODEL = ::Product

    module Scopes
      include ::Query::Scopes
      include Concerns::ByCode
    end
  end
end
