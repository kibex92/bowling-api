require 'rails_helper'

RSpec.describe Frame, type: :model do
  subject(:game) { Game.create }
  subject(:frame) { Frame.create(game: game, first_roll: 5, second_roll: 5) }
  
  before do
    allow_any_instance_of(Game).to receive(:create_frames)
  end

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
end
