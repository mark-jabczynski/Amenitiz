# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountRule, type: :model do
  describe 'enums' do
    it 'defines category enum' do
      should define_enum_for(:category).with_values(
        buy_one_get_one_free: 'BuyOneGetOneFree',
        buy_three_or_more_strawberries: 'BuyThreeOrMoreStrawberries',
        buy_three_or_more_coffees: 'BuyThreeOrMoreCoffees'
      ).backed_by_column_of_type(:string)
    end
  end
end
