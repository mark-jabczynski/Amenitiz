# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::Subactions::UpdateDiscount do
  subject { described_class.new(order).call }

  context 'when order has no discount' do
    let(:product) { create(:product, price: 3.11) }

    let(:order) { create(:order, discount: 0, basket: { product.code => 3 }) }

    it { is_expected.to eq(0.to_money) }
  end

  context 'when order has buy_one_get_one_free discount' do
    let(:discount) { create(:discount_rule, category: DiscountRule.categories[:buy_one_get_one_free]) }
    let(:product) { create(:product, price: 3.11, discount_rule: discount) }

    let(:order) { create(:order, discount: 0, basket: { product.code => 3 }) }

    it { is_expected.to eq(3.11.to_money) }
  end

  context 'when order has buy_three_or_more_strawberries discount' do
    let(:discount) { create(:discount_rule, category: DiscountRule.categories[:buy_three_or_more_strawberries]) }
    let(:product) { create(:product, price: 5.00, discount_rule: discount) }

    let(:order) { create(:order, discount: 0, basket: { product.code => 4 }) }

    it { is_expected.to eq(2.00.to_money) }
  end

  context 'when order has buy_three_or_more_coffees discount' do
    let(:discount) { create(:discount_rule, category: DiscountRule.categories[:buy_three_or_more_coffees]) }
    let(:product) { create(:product, price: 11.23, discount_rule: discount) }

    let(:order) { create(:order, discount: 0, basket: { product.code => 4 }) }

    it { is_expected.to eq(14.98.to_money) }
  end
end
