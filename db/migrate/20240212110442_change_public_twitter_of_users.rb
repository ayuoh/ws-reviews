class ChangePublicTwitterOfUsers < ActiveRecord::Migration[7.1]
  def up
    remove_column :users, :public_twitter
    add_column :users, :public_twitter, :boolean, default: true, null: false
  end

  def down
    remove_column :users, :public_twitter
    add_column :users, :public_twitter, :boolean, default: false, null: false
  end
end
