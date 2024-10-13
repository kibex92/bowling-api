class Frame < ApplicationRecord
  belongs_to :game

  validates_numericality_of :first_roll, :second_roll, :third_roll, greater_than_or_equal_to: 0, less_than_or_equal_to: 10, only_integer: true
  validates_numericality_of :score, greater_than_or_equal_to: 0, less_than_or_equal_to: 300, only_integer: true
  validate :number_not_greater_than_ten

  before_validation :set_number, on: :create

  default_scope { order(number: :asc) }




  private

  def set_number
    self.number = game.frames.any? ? game.frames.last.number + 1 : 1
  end

  def number_not_greater_than_ten
    if number > 10
      errors.add(:number, "can't be greater than 10")
    end
  end
end
