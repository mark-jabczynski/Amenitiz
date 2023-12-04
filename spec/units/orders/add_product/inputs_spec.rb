# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AddProduct::Inputs do
  subject { described_class.new(params: params).call.errors.to_h }

  let(:order) { create(:order) }
  let(:product) { create(:product) }
  let(:quantity) { 1 }
  let(:params) { { uuid: order&.uuid, product_code: product&.code, quantity: quantity } }

  it { is_expected.to be_empty }

  context 'when order is absent' do
    let(:order) { nil }

    it { is_expected.to be_empty }
  end

  context 'when product code is missing' do
    let(:product) { nil }

    it { is_expected.to eq(product_code: ['must be a string']) }
  end

  context 'when product does not exist' do
    let(:product) { build(:product) }

    it { is_expected.to eq(nil => ['Product code not found.']) }
  end

  context 'when quantity is missing' do
    let(:quantity) { nil }

    it { is_expected.to eq(quantity: ['must be an integer']) }
  end

  context 'when quantity is less than 1' do
    let(:quantity) { 0 }

    it { is_expected.to eq(quantity: ['must be greater than 0']) }
  end

  context 'when quantity is greater than 10' do
    let(:quantity) { 11 }

    it { is_expected.to eq(quantity: ['must be less than or equal to 10']) }
  end
end
