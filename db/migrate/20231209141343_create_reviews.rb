class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :web_page, null: false, foreign_key: true
      t.string :title, null:false, limit: 200
      t.string :content, null:false, limit: 1000
      t.datetime :implementation_start_date, null: false
      t.datetime :implementation_lase_date, null: false
      t.datetime :recruitment_start_date
      t.datetime :recruitment_lase_date
      t.string :prefecture, limit: 5
      t.integer :fee
      t.integer :target, default: 0

      t.timestamps
    end
  end
end
