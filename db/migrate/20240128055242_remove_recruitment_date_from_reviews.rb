class RemoveRecruitmentDateFromReviews < ActiveRecord::Migration[7.1]
  def up
    remove_column :reviews, :recruitment_start_date
    remove_column :reviews, :recruitment_last_date
  end

  def down
    add_column :reviews, :recruitment_start_date, :datetime
    add_column :reviews, :recruitment_last_date, :datetime
  end
end
