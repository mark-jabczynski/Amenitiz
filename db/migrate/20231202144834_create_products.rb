class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :name, null: false, unique: true
      t.references :discount_rule, foreign_key: true
      t.monetize :price, null: false, default: 0

      t.timestamps
    end
  end
end
