class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|

      t.string :title, null: false
      t.text :content, null: false

      t.references :user, null: false

      t.integer :category_id,             null: false
      t.integer :condition_id,            null: false
      t.integer :shipping_fee_burden_id,  null: false
      t.integer :prefecture_id,           null: false
      t.integer :shipping_day_id,         null: false
      t.integer :price,                   null: false

      t.timestamps
    end
  end
end
