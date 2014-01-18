class PhotosController < ApplicationController
	def index
		@user = User.find(params[:page_id])
		@album = Album.find(params[:album_id])			
		@photos = @album.photos.all
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.create(photoParam)
		@photo.album_id = params[:album_id]
		if @photo.save
			redirect_to album_path(@photo.album_id)
		else
			flash[:alert] = @photo.errors.full_messages
			redirect_to album_path(@photo.album_id)
		end
	end

	def show
		@photo = photo.find(params[:id])
	end
	
	def destroy
		@photo = Photo.find(params[:id])
		@photo.destroy;
		redirect_to album_path(@photo.album_id)
	end

	private

		def photoParam
			params.require(:photo).permit( :purl, :pname)
		end
end
