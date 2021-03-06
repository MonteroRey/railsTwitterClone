module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    def logged_in?
        !current_user.nil?
    end
    def current_user
        if (user_id = session[:user_id])
          @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
          user = User.find_by(id: user_id)
          if user&.authenticated?(cookies[:remember_token])
            log_in(user)
            @current_user = user
          end
        end
    end
    def current_user?(user)
      user && user == current_user
    end
    ################# remember me ##################
    def forget(user)
      user.forget          #define at the model
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
    def remember(user)
      user.remember        #define at the model
      cookies.permanent.encrypted[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
    ############################ log out ###################
    def log_out
      forget(current_user)
      reset_session
      @current_user = nil
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { danger: "Please sign in." }
      end
    end

end
