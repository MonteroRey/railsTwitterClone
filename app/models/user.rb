class User < ApplicationRecord

    #attr_accessible :email, :name, :password, :password_confirmation
    # attr_accessor :password, :password_confirmation
    before_save { self.email = email.downcase }
    has_secure_password
    has_many :tweets, dependent: :destroy
end
