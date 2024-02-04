class RemoveTargetFromReviews < ActiveRecord::Migration[7.1]
  def up
    remove_column :reviews, :target
  end

  def down
    add_column :reviews, :target, :integer, default: 0
  end
end
