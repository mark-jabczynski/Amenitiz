# frozen_string_literal: true

class DiscountRule < ApplicationRecord
  # TODO: Move to constants/configs/ymls
  enum category: {
    buy_one_get_one_free: 'BuyOneGetOneFree',
    buy_three_or_more_strawberries: 'BuyThreeOrMoreStrawberries',
    buy_three_or_more_coffees: 'BuyThreeOrMoreCoffees'
  }
end
