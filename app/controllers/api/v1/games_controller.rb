class Api::V1::GamesController < ApplicationController
    def create
        game = Game.create!
        render  json: game, status: :created
    end
end
