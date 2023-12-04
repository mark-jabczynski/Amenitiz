# frozen_string_literal: true

module Orders
  module AddProduct
    class Action
      def initialize(inputs:)
        @inputs = inputs
      end

      def call
        order.tap do |o|
          add_product_to_the_basket(o)
          update_total_price(o)
          update_discount(o)
        end

        Command.save(order)
      end

      private

      attr_reader :inputs

      def add_product_to_the_basket(order)
        order.basket[product.code] = order.basket[product.code].to_i + quantity
      end

      def update_total_price(order)
        order.total_price += product.price * quantity
      end

      def update_discount(order)
        # TODO: Update discount
        warn 'Not implemented yet'
      end

      def quantity
        inputs.attributes[:quantity]
      end

      def product
        @product ||= ::Queries::Product.by_code(inputs.attributes[:product_code]).sole
      end

      def order
        @order ||= ::Queries::Order.find_or_initialize_by(uuid: inputs.attributes[:uuid]) do |o|
          o.uuid = SecureRandom.uuid
        end
      end
    end
  end
end
