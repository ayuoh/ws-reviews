class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null:false, limit: 30
      t.string :description, null:false, limit: 1000
      t.string :mail, null:false, limit: 320
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
  end
end
