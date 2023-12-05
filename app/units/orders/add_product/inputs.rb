# frozen_string_literal: true

module Orders
  module AddProduct
    class Inputs < ::Inputs
      config.messages.namespace = :order

      MAX_QUANTITY = 10

      json do
        required(:product_code).filled(:string)
        required(:quantity).filled(:integer, gt?: 0, lteq?: MAX_QUANTITY)
        optional(:uuid).maybe(:string)
      end

      rule(:product_code) do
        next if ::Queries::Product.by_code(value).exists?

        base.failure(:product_record_not_found)
      end
    end
  end
end
