# frozen_string_literal: true

module Orders
  module AddProduct
    module Subactions
      class UpdateTotalPrice
        def initialize(order)
          @order = order
        end

        def call
          total_price - order.discount
        end

        private

        attr_reader :order

        def total_price
          prices_sum = 0.to_money

          product_codes.each do |product_code|
            prices_sum += get_product_price(product_code)
          end

          prices_sum
        end

        def get_product_price(product_code)
          products.find { |product| product.code == product_code }.price * order.basket[product_code]
        end

        def product_codes
          order.basket.keys
        end

        def products
          ::Queries::Product.by_code(product_codes)
        end
      end
    end
  end
end
