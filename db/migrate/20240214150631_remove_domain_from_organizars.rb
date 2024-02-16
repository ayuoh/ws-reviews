class RemoveDomainFromOrganizars < ActiveRecord::Migration[7.1]
  def up
    remove_column :organizers, :domain
  end

  def down
    add_column :organizers, :domain, null: false, limit: 260
  end
end
