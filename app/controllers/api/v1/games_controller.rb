class Api::V1::GamesController < ApplicationController
    before_action :set_game, only: [:show]
    def create
        game = Game.create!
        render  json: game, status: :created
    end

    def show
        render json: {
            game: {
              id: @game.id,
              frames: @game.frames,
              total_score: @game.frames&.last&.score || 0
            }
          }
    end

    private

    def set_game
        @game = Game.find(params[:id])
    end
end
