# frozen_string_literal: true

module Queries
  module Concerns
    module ByCode
      def by_code(code)
        where(code: code)
      end
    end
  end
end
