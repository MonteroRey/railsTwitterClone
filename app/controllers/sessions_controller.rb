class SessionsController < ApplicationController
    
    def new
    end
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password])
          reset_session
          params[:session][:remember_me] == "1" ? remember(user) : forget(user)
          log_in(user)
          redirect_to home_url
        else
          flash.now[:danger] = "Invalid email/password combination"
          render :new
        end
    end
    
end
