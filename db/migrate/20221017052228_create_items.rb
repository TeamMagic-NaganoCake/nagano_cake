class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,           null: false
      t.boolean :sale_status,        null: false, default: true
      t.string :item_name,           null: false
      t.text :item_body,             null: false
      t.integer :none_taxed_price,   null: false
      t.timestamps
    end
  end
end
