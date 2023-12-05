# frozen_string_literal: true

module Orders
  module AddProduct
    class EntryPoint < ::EntryPoint
      def initialize(order_uuid:, product_code:, quantity: 1)
        @inputs = Inputs.new(params: { uuid: order_uuid, product_code: product_code, quantity: quantity })
        @action = Action.new(inputs: inputs)
      end
    end
  end
end
