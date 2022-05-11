class UsersController < ApplicationController
    
    def index 
        @users = User.all
    end
    def show
        #@tweet = current_user
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
    
        if @user.save
          log_in @user
          #format.html { render action: "thanks", notice: 'User was successfully created.' }
          flash[:success] = "Welcome to Twitter Clone!"
          redirect_to @user
        else
          render "new", status: :unprocessable_entity
        end
    end
    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :slug)
    end
end
