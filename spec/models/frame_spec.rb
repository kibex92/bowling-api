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
      expect(game.frames.last.score).to eq(10)
    end

    it "calculates the score of 2 spare frames" do
      first_frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      second_frame = Frame.create(game: game, first_roll: 5, second_roll: 5)
      
      game.frames.each(&:calculate_score)
      expect(game.frames.first.score).to eq(15)
    end
  end

    it "calculates the score for 3 strike frames" do 
      first_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
      second_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
      third_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
      
      game.frames.each(&:calculate_score)
      expect(game.frames.first.score).to eq(30)
    end

    it "calculates the score for 2 strikes and a normal frame" do 
      first_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
      second_frame = Frame.create(game: game, first_roll: 10, second_roll: 0)
      third_frame = Frame.create(game: game, first_roll: 5, second_roll: 0)
      
      game.frames.each(&:calculate_score)
      expect(game.frames.first.score).to eq(25)
    end

    it "calculates the score for a perfect game" do 
      9.times do 
        Frame.create(game: game, first_roll: 10)
      end

      Frame.create(game: game, first_roll: 10, second_roll: 10, third_roll: 10)
      
      game.frames.each(&:calculate_score)
      expect(game.frames.last.score).to eq(300)
    end
end
