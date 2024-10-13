require 'rails_helper'

RSpec.describe Game, type: :model do
    describe '#create_frames' do
        it 'creates 10 frames' do
            game = Game.create
            expect(game.frames.count).to eq(10)
        end
    end
end
