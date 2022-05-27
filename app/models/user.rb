class User < ApplicationRecord
    #attr_accessible :email, :name, :password, :password_confirmation
    # attr_accessor :password, :password_confirmation
    acts_as_voter         # model votable helper

    attr_accessor :remember_token
    has_secure_password
    has_many :tweets, dependent: :destroy
    #asssociation for the following
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  inverse_of: :follower,
                                  dependent: :destroy
    has_many :following, through: :active_relationships,  source: :followed
    #association for the followers
    has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   inverse_of: :followed,
                                   dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower
    ######################### comment #####################
    has_many :comments, dependent: :destroy



    ######################### remember block #############
    def remember
        self.remember_token = self.class.new_token
        update_attribute(:remember_digest, self.class.digest(remember_token))
    end
    def authenticated?(remember_token)
        return false if remember_digest.nil?
    
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
      end
    def forget
        update_attribute(:remember_digest, nil)
    end
    #########################################################
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
    ####################### remember me #######################################################################################
    def self.digest(string)            ####### I define it as a class method instead of instance method dont know why #########
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
