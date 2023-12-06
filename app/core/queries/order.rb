# frozen_string_literal: true

module Queries
  class Order < ::Query
    MODEL = ::Order

    module Scopes
      include Query::Scopes

      def by_uuid(uuid)
        where(uuid: uuid)
      end
    end
  end
end
