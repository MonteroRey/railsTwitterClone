class CommentsController < ApplicationController
    def new 

    end

    def create 
        @comment = current_user.comments.build(comments_params)
        if @comment.save
            flash[:success] = 'Comment saved!'
        else
            flash[:danger] = 'Something went wrong...'
        end
        redirect_back(fallback_location: root_path)
    end


    private

    def comments_params
      params.require(:comment).permit(:content, :tweet_id)
    end
end
