class Frame < ApplicationRecord
  belongs_to :game

  validates_numericality_of :first_roll, :second_roll, :third_roll, greater_than_or_equal_to: 0, less_than_or_equal_to: 10, only_integer: true
  validates_numericality_of :score, greater_than_or_equal_to: 0, less_than_or_equal_to: 300, only_integer: true

  
end
