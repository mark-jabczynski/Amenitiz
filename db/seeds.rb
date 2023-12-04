# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

DiscountRule.create! [
  { name: 'Buy one get one free', category: DiscountRule.categories[:buy_one_get_one_free] },
  { name: 'Buy three or more strawberries', category: DiscountRule.categories[:buy_three_or_more_strawberries] },
  { name: 'Buy three or more coffees', category: DiscountRule.categories[:buy_three_or_more_coffees] }
] unless DiscountRule.exists?

Product.create! [
  { code: 'GR1', name: 'Green Tea', price: 3_11, discount_rule: DiscountRule.buy_one_get_one_free.take },
  { code: 'SR1', name: 'Strawberries', price: 5_00, discount_rule: DiscountRule.buy_three_or_more_strawberries.take },
  { code: 'CF1', name: 'Coffee', price: 11_23, discount_rule: DiscountRule.buy_three_or_more_strawberries.take }
] unless Product.exists?

Order.create! [
  { basket: [{ GR1: 2 }], total_price_cents: 3_11, discount_cents: 3_11, uuid: SecureRandom.uuid },
  { basket: [{ SR1: 3, GR1: 1 }], total_price_cents: 16_61, discount_cents: 1_50, uuid: SecureRandom.uuid },
  { basket: [{ SR1: 1, GR1: 1, CF1: 3 }], total_price_cents: 30_57, discount_cents: 11_23, uuid: SecureRandom.uuid }
] unless Order.exists?
