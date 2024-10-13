class Api::V1::FramesController < ApplicationController
    before_action :set_game
    before_action :set_frame, only: [:update]

    def update
        @frame.update(frame_params)
        render json: @frame, status: :ok
    end

    private
    def set_frame
        @frame = Frame.find_by(game: @game, number: params[:number])
    end
    def set_game
        @game = Game.find(params[:game_id])
    end

    def frame_params
        params.permit(:first_roll, :second_roll, :third_roll)
    end
end
