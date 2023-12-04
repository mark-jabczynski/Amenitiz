# frozen_string_literal: true

module Orders
  module AddProduct
    module Subactions
      class UpdateDiscount
        def initialize(order)
          @order = order
        end

        # Comment: The discounts and obscure. We can discuss the rules
        # TODO: Move enum to config/constatants/yaml for flexibility and to add threashold and rules
        def call
          discount = 0.to_money

          product_codes.each do |product_code|
            product = get_product_with_discount_category(product_code)

            discount += buy_one_get_one_free(product) if buy_one_get_one_free?(product)
            discount += buy_three_or_more_strawberries(product) if buy_three_or_more_strawberries?(product)
            discount += buy_three_or_more_coffees(product) if buy_three_or_more_coffees?(product)
          end

          discount
        end

        private

        attr_reader :order

        # If u buy 2 or more of the same product, you get one for free.
        def buy_one_get_one_free(product)
          product.price
        end

        def buy_one_get_one_free?(product)
          product&.discount_category == DiscountRule.categories[:buy_one_get_one_free] &&
            order.basket[product.code] >= 2
        end

        # If you buy 3 or more strawberries, the price should drop to 4.50€.
        def buy_three_or_more_strawberries(product)
          (product.price * order.basket[product.code]) - (4.50.to_money * order.basket[product.code])
        end

        def buy_three_or_more_strawberries?(product)
          product&.discount_category == DiscountRule.categories[:buy_three_or_more_strawberries] &&
            order.basket[product.code] >= 3
        end

        # If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.
        def buy_three_or_more_coffees(product)
          (product.price * order.basket[product.code]) -
            (product.price.to_d * 2 / 3 * order.basket[product.code]).to_money
        end

        def buy_three_or_more_coffees?(product)
          product&.discount_category == DiscountRule.categories[:buy_three_or_more_coffees] &&
            order.basket[product.code] >= 3
        end

        def product_codes
          order.basket.keys
        end

        def products
          @products ||= ::Queries::Product.with_discount_category.by_code(product_codes)
        end

        def get_product_with_discount_category(product_code)
          products.find { |p| p.code == product_code }
        end
      end
    end
  end
end
