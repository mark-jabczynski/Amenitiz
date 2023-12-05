# frozen_string_literal: true

module Queries
  class Order < ::Query
    MODEL = ::Order

    module Scopes
      include Query::Scopes
    end
  end
end
