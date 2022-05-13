class Tweet < ApplicationRecord
    belongs_to :user

    has_one_attached :image  #to render image in the tweets controller
end
