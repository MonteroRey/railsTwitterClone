class TweetController < ApplicationController
    def index
        @tweets = Tweet.includes(:user).with_attached_image.paginate(page: params[:page])
        render "home/index"
    end
end
