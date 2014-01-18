class AddFieldsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :description, :string
    add_column :albums, :name, :string
    add_column :albums, :user_id, :integer
  end
end
