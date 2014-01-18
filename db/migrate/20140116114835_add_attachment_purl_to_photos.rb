class AddAttachmentPurlToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :purl
    end
  end

  def self.down
    drop_attached_file :photos, :purl
  end
end
