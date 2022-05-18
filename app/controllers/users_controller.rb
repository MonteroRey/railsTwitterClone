class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update, :destroy]
    
    def index 
        @users = User.all
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
          log_in @user
          
          flash[:success] = "Welcome to Twitter Clone!"
          redirect_to @user
        else
          render "new", status: :unprocessable_entity
        end
    end
    def show
        @user  = User.find(params[:id])
        @tweet = current_user.tweets.build if logged_in?
        @tweets = @user.tweets.with_attached_image.paginate(page: params[:page])
    end

    def edit
        
    end
    
    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :slug)
    end
    #################################################################
    ######################  follower/following  ###############################
    def following
        @title = "Following"
        @users = @user.following.paginate(page: params[:page])
        render :show_follow
    end

    def followers
        @title = "Followers"
        @users = @user.followers.paginate(page: params[:page])
        render :show_follow
    end

    def correct_user
        unless current_user?(@user)
          redirect_to(root_path)
        end
    end

    #############################################################################
    
end
