module WelcomeHelper
    def index 
        redirect_to home_path if logged_in
    end
end
