class AddColumnToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :scope, :string
  end
end
