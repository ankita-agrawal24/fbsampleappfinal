class Photo < ActiveRecord::Base
	belongs_to :album
	validates :pname, presence: true
	validates :purl,  presence: true
	has_attached_file :purl, :styles => { :small => "150x150" }
end
