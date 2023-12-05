# frozen_string_literal: true

module Queries
  class Product < ::Query
    MODEL = ::Product

    module Scopes
      include ::Query::Scopes
      include Concerns::ByCode

      def with_discount_category
        select(arel_table[Arel.star], discount_rule[:category].as('discount_category'))
          .joins(:discount_rule)
      end

      private

      def discount_rule
        DiscountRule.arel_table
      end
    end
  end
end
