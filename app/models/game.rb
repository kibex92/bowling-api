class Game < ApplicationRecord
    has_many :frames, dependent: :destroy

    after_create :create_frames

    def create_frames
        10.times do
            Frame.create!(game: self)
        end
    end
end
