# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::EntryPoint do
  subject { described_class.call(order_uuid: order&.uuid, product_code: product&.code) }

  let(:order) { nil }
  let(:product) { create(:product, price: 1) }

  it 'creates a new order' do
    expect { subject }.to change(Queries::Order, :all).from([]).to(
      a_collection_containing_exactly(
        an_object_having_attributes(
          uuid: an_instance_of(String),
          total_price: 1.to_money,
          basket: { product.code => 1 }
        )
      )
    )
  end

  context 'when order exists' do
    let(:order) { create(:order, total_price: 1, basket: { product.code => 1 }) }

    it 'updates the order' do
      expect { subject }.to change(Queries::Order, :all)
        .from(
          a_collection_containing_exactly(
            an_object_having_attributes(
              uuid: order.uuid,
              total_price: 1.to_money,
              basket: { product.code => 1 }
            )
          )
        ).to(
          a_collection_containing_exactly(
            an_object_having_attributes(
              uuid: order.uuid,
              total_price: 2.to_money,
              basket: { product.code => 2 }
            )
          )
        )
    end
  end

  context 'when quantity is passed' do
    subject { described_class.call(order_uuid: order&.uuid, product_code: product&.code, quantity: quantity) }

    let(:quantity) { 2 }

    it 'creates a new order' do
      expect { subject }.to change(Queries::Order, :all).from([]).to(
        a_collection_containing_exactly(
          an_object_having_attributes(
            uuid: an_instance_of(String),
            total_price: 2.to_money,
            basket: { product.code => quantity }
          )
        )
      )
    end
  end

  context 'when params are invalud' do
    subject { described_class.call(order_uuid: order&.uuid, product_code: product&.code, quantity: quantity) }

    let(:quantity) { -1 }
    let(:product) { build(:product) }

    it 'raises an error' do
      expect { subject }.to raise_error(
        ValidationError, { quantity: ['quantity must be greater than 0'], nil => ['Product code not found.'] }.to_s
      )
    end
  end
end
