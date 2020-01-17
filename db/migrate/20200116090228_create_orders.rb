class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :number, null: false
      t.integer :user_id
      t.integer :item_count
      t.decimal :item_total
      t.string :status

      t.timestamps
    end

    add_index :orders, :number, unique: true
  end
end
