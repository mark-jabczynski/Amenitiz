# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to monetize(:discount).with_currency(:eur) }
  it { is_expected.to monetize(:total_price).with_currency(:eur) }
end
