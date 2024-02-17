class AddIndexNameFromOrganizars < ActiveRecord::Migration[7.1]
  def change
    add_index :organizers, :name
  end
end
