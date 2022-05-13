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
    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { danger: "Please sign in." }
      end
    end

    def logged_in?
      !current_user.nil?
    end
################################ log out ########
    def destroy
      log_out if logged_in?
      redirect_to root_url
    end

    
end
