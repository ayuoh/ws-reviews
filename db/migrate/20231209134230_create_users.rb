class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null:false, limit: 30
      t.string :description, null:false, limit: 1000
      t.string :mail, null:false, limit: 320
      t.string :twitter
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
    add_index :users, :mail, unique: true
    add_index :users, :twitter, unique: true
  end
end
