class Api::V1::FramesController < ApplicationController
    before_action :set_game
    before_action :set_frame, only: [:update]

    def create
        frame = @game.frames.create!(frame_params)
        frame.calculate_score
        render json: frame, status: :created
    end
    def update
        @frame.update(frame_params)
        @frame.calculate_score
        render json: @frame, status: :ok
    end

    private 

    def set_frame 
        if params[:number].to_i.between?(1, 10)
            @frame = Frame.find_by(game: @game, number: params[:number])
            
            render json: { error: "Frame not found for game and number #{params[:number]}." }, status: :not_found if @frame.nil?
        else
            render json: { error: "Invalid frame number. Must be between 1 and 10." }, status: :unprocessable_entity
        end
    end 
    
    def set_game
        @game = Game.find(params[:game_id])
    end

    def frame_params
        params.permit(:first_roll, :second_roll, :third_roll, :game_id)
    end
end
