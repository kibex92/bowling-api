class Game < ApplicationRecord
    has_many :frames, dependent: :destroy

    default_scope { includes(:frames )}
end
