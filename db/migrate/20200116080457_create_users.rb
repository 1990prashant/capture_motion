class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.string :mobile, null: false, default: ""
      t.string :password_token, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :last_login
      t.integer :login_count
      t.string :role, default: ""

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
