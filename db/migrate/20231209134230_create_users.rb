class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :description
      t.string :twitter_name, null: false
      t.string :twitter_id, null: false
      t.string :avatar

      t.timestamps
    end
    add_index :users, :twitter_id, unique: true
  end
end
