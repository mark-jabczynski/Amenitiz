# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { 'CF1' }
    name { 'Coffee' }
    price_cents { 11_23 }
  end
end
