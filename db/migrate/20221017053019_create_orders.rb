class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id,           null: false
      t.integer :order_status,          null: false, default: 0
      t.integer :postage,               null: false, default: 800
      t.integer :billing_price,         null: false
      t.string :order_postcode,         null: false
      t.string :order_address,          null: false
      t.string :order_address_name,     null: false
      t.integer :payment,               null: false, default: 0

      t.timestamps
    end
  end
end
