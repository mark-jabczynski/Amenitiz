require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      orders = create_list(:order, 2)

      get orders_path

      expect(response.body).to match(/#{orders[0].uuid}/)
      expect(response.body).to match(/#{orders[1].uuid}/)
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      order = create(:order)

      get order_path(order.uuid)

      expect(response.body).to match(/#{order.uuid}/)
    end
  end

  describe 'POST /add_product' do
    it 'redirecs to show page' do
      order = create(:order, basket: {})
      product = create(:product)

      post add_product_path(uuid: order.uuid, product_code: product.code)

      expect(response.body).to match(/#{order.uuid}/)
      expect(response).to redirect_to(order_path(order.uuid, product_code: product.code))
    end
  end
end
