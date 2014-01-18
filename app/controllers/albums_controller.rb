class AlbumsController < ApplicationController
	def index
		@user = User.find(params[:page_id])
	
		if !user_signed_in?
			@albums = Album.where("user_id = ? AND scope = ?",params[:page_id], "Public")			

		elsif @user == current_user
			@albums = Album.where("user_id = ? ",params[:page_id])

		elsif (Relationship.find_by(follower_id: current_user.id,followed_id: @user.id) && Relationship.find_by(follower_id: @user.id,followed_id: current_user.id))
			@albums = Album.where("user_id = ? AND scope = ? OR scope = ?",params[:page_id], "Friends", "Public")
		end
	end

	def new
		@album = Album.new
		1.times { @album.photos.build }
	end

	def create
		@album = Album.new(albumParam)
		@album.user_id = current_user.id
		if @album.save
			flash[:notice] = "Successfully created Albums"
			redirect_to album_path(@album.id)
		else
			render :action => 'new'
		end
	end

	def show
		@album = Album.find(params[:id])
		@photos = @album.photos
	end

	private

		def albumParam
			params.require(:album).permit(:name, :description, :scope)
		end
end
