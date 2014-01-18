class AddFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :description, :string
    add_column :photos, :pname, :string
    add_column :photos, :album_id, :integer
    add_column :photos, :purl, :string
  end
end
