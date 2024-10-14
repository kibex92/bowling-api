class Frame < ApplicationRecord
  belongs_to :game

  validates_numericality_of :first_roll, :second_roll, :third_roll, greater_than_or_equal_to: 0, less_than_or_equal_to: 10, only_integer: true
  validates_numericality_of :score, greater_than_or_equal_to: 0, less_than_or_equal_to: 300, only_integer: true
  validate :number_not_greater_than_ten
  
  before_validation :set_number, on: :create

  default_scope { order('number ASC') }

  
  def calculate_score
    game.frames.each_with_index do |frame, index|
      previous_score = get_frame(index - 1).score
      frame.update_columns(score: previous_score + calculate_frame_score(frame, index))
    end
  end
  
  def calculate_frame_score(frame, index)
    return strike_score(index) if frame.strike?
    return spare_score(index) if frame.spare?
    frame.frame_score
  end
  
  def strike_score(index)
    return get_frame(index).frame_score if get_frame(index).last?
  
    one_ahead = get_frame(index + 1)
    two_ahead = get_frame(index + 2)
  
    if one_ahead.strike?
      return 30 if two_ahead.strike?
      return 20 + two_ahead.first_roll if get_frame(index).number != 9
    end
  
    10 + one_ahead.first_roll + one_ahead.second_roll
  end
  
  def spare_score(index)
    return get_frame(index).frame_score if get_frame(index).last?
  
    get_frame(index).frame_score + get_frame(index + 1).first_roll
  end
  
  def get_frame(index)
    return Frame.new if index_out_of_bounds?(index)
    game.frames[index]
  end

  def frame_score
    first_roll + second_roll + third_roll
  end

  def strike?
    first_roll == 10
  end

  def spare?
    !strike? && first_roll + second_roll == 10
  end

  def last?
    number == 10
  end

  private

  def set_number
    self.number = game.frames.any? ? game.frames.last.number + 1 : 1
  end

  def index_out_of_bounds?(index)
    index < 0 || index >= game.frames.size
  end
  def number_not_greater_than_ten
    if number > 10
      errors.add(:number, "can't be greater than 10")
    end
  end
end
