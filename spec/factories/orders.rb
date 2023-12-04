# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    basket { '' }
    total_price_cents { 1 }
    discount_price { 1 }
    uuid { 'MyString' }
  end
end
