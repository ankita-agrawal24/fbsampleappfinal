class RelationshipsController < ApplicationController
 def create
    @user = User.find(params[:user_id])
    current_user.follow!(@user)
    redirect_to page_path(@user)
  end

  def destroy
    @user = Relationship.find_by(followed_id: params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to page_path(@user)
  end
end
