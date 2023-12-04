# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:discount_rule) }
  end

  it { is_expected.to monetize(:price).with_currency(:eur) }
end
