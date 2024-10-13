require 'rails_helper'

RSpec.describe Frame, type: :model do
  subject(:game) { Game.create }
  subject(:frame) { Frame.create(game: game, first_roll: 5, second_roll: 5) }

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:first_roll) }
    it { is_expected.to validate_numericality_of(:second_roll) }
    it { is_expected.to validate_numericality_of(:first_roll) }
    it { should belong_to(:game) }
  end

  describe '#set_number' do
    it 'sets the number of the frame' do
      frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      expect(frame.number).to eq(1)
    end

    it 'should not allow frame numbers greater than 10' do
      frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      frame.update(number: 11)
      expect(frame).not_to be_valid
    end
  end

  describe '#calculate_score' do
    it "returns the sum of the rolls" do
      frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      expect(frame.frame_score).to eq(10)
    end

    it "calculates the score of 2 normal frames" do
      first_frame = Frame.create(game: game, first_roll: 5, second_roll: 0)
      second_frame = Frame.create(game: game, first_roll: 5, second_roll: 0)
      
      game.frames.each(&:calculate_score)

      frames = game.frames
      
      expect(frames.last.score).to eq(10)
    end

    it "calculates the score of 2 spare frames" do
      first_frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      second_frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      
      game.frames.each(&:calculate_score)

      frames = game.frames
      
      expect(frames.first.score).to eq(15)
    end
  end

  it "calculated the score for 3 strike frames" do 
    first_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
    second_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
    third_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
    
    game.frames.each(&:calculate_score)

    frames = game.frames
    
    expect(frames.first.score).to eq(30)
  end

  it "calculated the score for 2 strike and a normal frame" do 
    first_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
    second_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
    third_frame = Frame.create(game: game, first_roll: 5, second_roll: 0)
    
    game.frames.each(&:calculate_score)

    frames = game.frames
    
    expect(frames.first.score).to eq(25)
  end
end
