# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::Subactions::UpdateTotalPrice do
  subject { described_class.new(order).call }

  context 'when order has no discount' do
    let(:product) { create(:product, price: 3.11) }
    let(:order) { create(:order, discount: 0, basket: { product.code => 3 }) }

    it { is_expected.to eq(9.33.to_money) }
  end

  context 'when order has buy_one_get_one_free discount' do
    let(:product) { create(:product, price: 3.11) }
    let(:order) { create(:order, discount: 3.11, basket: { product.code => 3 }) }

    it { is_expected.to eq(6.22.to_money) }
  end

  context 'when order has buy_three_or_more_strawberries discount' do
    let(:product) { create(:product, price: 5.00) }
    let(:order) { create(:order, discount: 2.00, basket: { product.code => 4 }) }

    it { is_expected.to eq(18.00.to_money) }
  end

  context 'when order has buy_three_or_more_coffees discount' do
    let(:product) { create(:product, price: 11.23) }
    let(:order) { create(:order, discount: 14.97, basket: { product.code => 4 }) }

    it { is_expected.to eq(29.95.to_money) }
  end
end
