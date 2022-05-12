class User < ApplicationRecord
    #attr_accessible :email, :name, :password, :password_confirmation
    # attr_accessor :password, :password_confirmation
    has_secure_password
    has_many :tweets, dependent: :destroy
    def remember
        self.remember_token = self.class.new_token
        update_attribute(:remember_digest, self.class.digest(remember_token))
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
end
