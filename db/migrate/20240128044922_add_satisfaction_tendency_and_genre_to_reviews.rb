class AddSatisfactionTendencyAndGenreToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :satisfaction, :integer, null: true, default: 50
    add_column :reviews, :genre, :string
  end
end
