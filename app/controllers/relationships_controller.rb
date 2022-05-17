class RelationshipsController < ApplicationController
    def create
        current_user.follow(@user)
        redirect_to @user
    end

    private
    def set_followed_user
      @user = User.find(params[:relationship][:followed_id])
    end
end