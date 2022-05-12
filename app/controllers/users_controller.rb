class UsersController < ApplicationController

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
        @user = User.find(params[:id])
        #@tweet = current_user.tweets.build if logged_in?
        #@tweets = @user.tweets.with_attached_image.paginate(page: params[:page])
    end
    
    private 
    def set_user
        #@user = User.find(params[:id])
        #@user = User.find_by!(slug: params[:id])
    end
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :slug)
    end
end
