# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    basket { { GR1: 2 } }
    total_price_cents { 2 }
    discount { 1 }
    uuid { SecureRandom.uuid }
  end
end
