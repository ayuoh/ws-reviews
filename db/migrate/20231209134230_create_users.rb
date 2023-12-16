class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null:false, limit: 30
      t.string :description, limit: 1000
      t.string :email, null:false, limit: 320
      t.string :twitter
      t.string :avatar
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :twitter, unique: true
  end
end
