class RemoveTitleFromReviews < ActiveRecord::Migration[7.1]
  def up
    remove_column :reviews, :title
  end

  def down
    add_column :reviews, :title, :string, limit: 200
  end
end
