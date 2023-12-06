# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      products = create_list(:product, 2)

      get products_path

      expect(response.body).to match(/#{products[0].code}/)
      expect(response.body).to match(/#{products[1].code}/)
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      product = create(:product)

      get product_path(product.code)

      expect(response.body).to match(/#{product.code}/)
    end
  end
end
