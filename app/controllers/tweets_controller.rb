class TweetsController < ApplicationController
  before_action :require_login #### to restrict non-logged-in users
  before_action :correct_user, only: [:destroy]
    def index
        @tweets = Tweet.includes(:user).with_attached_image.paginate(page: params[:page])
        render "home/index"
    end
    def create
        @tweet = current_user.tweets.build(tweet_params)
        @tweet.image.attach(tweet_params[:image])
        if @tweet.save
          flash[:success] = "Tweet created!"
          redirect_to root_url
        else
          flash[:danger] = @tweet.errors.full_messages.to_sentence
          redirect_to root_url
        end
    end
    ############################# delete tweet #####################
    def destroy
      @tweet.destroy
      redirect_to root_url
    end
    private
    def tweet_params
        params.require(:tweet).permit(:content, :image)
    end
    def correct_user
      @tweet = current_user.tweets.find_by(id: params[:id])
      redirect_to root_url if @tweet.nil?
    end

    #### to restrict non-logged-in users
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to(root_path) # halts request cycle
      end
    end
    
end
