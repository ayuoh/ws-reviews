class CreateWebPages < ActiveRecord::Migration[7.1]
  def change
    create_table :web_pages do |t|
      t.references :organizer, null: false, foreign_key: true
      t.string :url, null:false, limit: 260
      t.string :opg_image

      t.timestamps
    end
  end
end
