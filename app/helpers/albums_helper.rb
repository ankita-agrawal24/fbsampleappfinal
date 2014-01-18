module AlbumsHelper
	def Result?(current_user,user)
		Relationship.find_by(follower_id: current_user.follower_id,followed_id: user.followed_id) && Relationship.find_by(follower_id: user.follower_id,followed_id: current_user.followed_id)
	end
end
