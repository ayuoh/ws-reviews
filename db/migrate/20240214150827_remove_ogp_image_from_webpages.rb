class RemoveOgpImageFromWebpages < ActiveRecord::Migration[7.1]
  def up
    remove_column :web_pages, :opg_image
  end

  def down
    add_column :web_pages, :opg_image
  end
end
