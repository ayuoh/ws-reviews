class AddPublicToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :public, :boolean, default: false, null: false
  end
end
