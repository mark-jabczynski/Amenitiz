class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.json :basket, default: {}, null: false
      t.monetize :total_price, null: false, default: 0
      t.monetize :discount, null: false, default: 0
      t.string :uuid, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
