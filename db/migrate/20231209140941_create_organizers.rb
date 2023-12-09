class CreateOrganizers < ActiveRecord::Migration[7.1]
  def change
    create_table :organizers do |t|
      t.string :domain, null: false, limit: 260
      t.string :name, limit: 50

      t.timestamps
    end
  end
end
