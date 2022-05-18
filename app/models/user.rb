class User < ApplicationRecord
    #attr_accessible :email, :name, :password, :password_confirmation
    # attr_accessor :password, :password_confirmation
    has_secure_password
    has_many :tweets, dependent: :destroy
    #asssociation for the following
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  inverse_of: :follower,
                                  dependent: :destroy
    has_many :following, through: :active_relationships,  source: :followed
    
    def remember
        self.remember_token = self.class.new_token
        update_attribute(:remember_digest, self.class.digest(remember_token))
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
    def following?(other_user)
        following.include?(other_user)      # has association :active_relatiomship in model user
    end

    def follow(other_user)
        following << other_user unless self == other_user
    end
    ##################### unfollow ############
    def unfollow(other_user)
        following.delete(other_user)
    end


    class << self
        def new_token
          SecureRandom.urlsafe_base64
        end
    end
end
