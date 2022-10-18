class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id,                     null: false 
      t.integer :item_id,                      null: false 
      t.integer :manufacture_status,           null: false, default: 0
      t.integer :nochange_taxed_price,         null: false 
      t.integer :amount,                       null: false 
      
      t.timestamps
    end
  end
end
