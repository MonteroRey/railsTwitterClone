class Tweet < ApplicationRecord
    acts_as_votable

    
    belongs_to :user

    ################ comments ###################
    has_many :comments, dependent: :destroy
    byebug
    has_one_attached :image  #to render image in the tweets controller

    validates :image, content_type: ["png", "jpeg"]

    def display_image
        image.variant(resize_to_limit: [700, 700])
    end
end
