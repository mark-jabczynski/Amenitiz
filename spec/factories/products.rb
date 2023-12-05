# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { 'MyString' }
    name { 'MyString' }
    discount_rule { nil }
    price_cents { 1 }
  end
end
