class CreateDiscountRules < ActiveRecord::Migration[7.0]
  def change
    create_table :discount_rules do |t|
      t.string :name, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
