# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::Action do
  subject { described_class.new(inputs: inputs).call }

  let(:order) { create(:order, discount: 0) }
  let(:product) { create(:product) }

  let(:inputs) do
    Orders::AddProduct::Inputs.new(params: { uuid: order.uuid, product_code: product.code, quantity: 1 }).tap(&:call)
  end

  let(:update_discount_class) { Orders::AddProduct::Subactions::UpdateDiscount }
  let(:update_discount_double) { instance_double(update_discount_class) }

  before do
    allow(update_discount_class).to receive(:new).with(order).and_return(update_discount_double)
  end

  it 'calls update_discount subaction' do
    expect(update_discount_double).to receive(:call)

    subject
  end

  it 'updates discount' do
    expect(update_discount_double).to receive(:call).and_return(11.to_money)

    expect { subject }.to change { order.reload.discount }.from(0.to_money).to(11.to_money)
  end
end
