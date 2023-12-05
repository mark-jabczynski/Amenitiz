# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::Action do
  subject { described_class.new(inputs: inputs).call }

  let(:order) { create(:order, discount: 0, total_price: 0) }
  let(:product) { create(:product) }

  let(:inputs) do
    Orders::AddProduct::Inputs.new(params: { uuid: order.uuid, product_code: product.code, quantity: 1 }).tap(&:call)
  end

  let(:update_discount_class) { Orders::AddProduct::Subactions::UpdateDiscount }
  let(:update_discount_double) { instance_double(update_discount_class) }

  let(:update_total_price_class) { Orders::AddProduct::Subactions::UpdateTotalPrice }
  let(:update_total_price_double) { instance_double(update_total_price_class) }

  before do
    allow(update_discount_class).to receive(:new).with(order).and_return(update_discount_double)
    allow(update_total_price_class).to receive(:new).with(order).and_return(update_total_price_double)
  end

  it 'calls subactions' do
    expect(update_discount_double).to receive(:call)
    expect(update_total_price_double).to receive(:call)

    subject
  end

  it 'updates total_price and discount' do
    expect(update_discount_double).to receive(:call).and_return(11.to_money)
    expect(update_total_price_double).to receive(:call).and_return(12.to_money)

    expect { subject }.to change { order.reload.discount }
      .from(0.to_money)
      .to(11.to_money)
      .and change { order.reload.total_price }
      .from(0.to_money)
      .to(12.to_money)
  end
end
