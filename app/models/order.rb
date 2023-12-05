# frozen_string_literal: true

class Order < ApplicationRecord
  monetize :total_price_cents
  monetize :discount_cents
end
