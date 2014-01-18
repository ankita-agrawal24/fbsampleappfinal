class PagesController < ApplicationController
 def home
 	  #@users = User.page(params[:page])
  	#@users = User.search(params[:search]).page(params[:page])
  	@users = Kaminari.paginate_array(User.search(params[:search])).page(params[:page]).per(6)
  end

  def show
  	@user =  User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    #@users = @user.followed_users
    @users = Kaminari.paginate_array(@user.followed_users).page(params[:page]).per(9)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = Kaminari.paginate_array(@user.followers).page(params[:page]).per(9)
    render 'show_follow'
  end
end
