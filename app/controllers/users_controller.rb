class UsersController < ApplicationController
    #before_action :require_login , except: :new
    before_action :set_user,       only: [ :edit, :update, :destroy]
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    #before_action :correct_user,   only: [:edit, :update, :destroy]
    
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
    ####################################### edit and save ##############################
    def edit
      @user = User.find(params[:id])
      
    end

    def update   
        if @user.update(user_params)        
          flash[:success] = "Profile was successfully updated."
          redirect_to @user
        else
          render :edit
        end
    end
    ############################################################################
    ###########################################################################
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
    

    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :slug)
    end
    

    # def correct_user
    #     unless current_user?(@user)
    #       redirect_to(root_path)
    #     end
    # end

    ################################################################################################################
    ##############################   set user using before_action for edit,update and destroy  #############################
    def set_user
      @user = User.find_by!(id: params[:id])
    end

    ########################
    # def require_login
    #   unless logged_in?
    #     flash[:error] = "You must be logged in to access this section"
    #     redirect_to(root_path) # halts request cycle
    #   end
    # end
end
