require 'rails_helper'

RSpec.describe "Frames", type: :request do
    let(:game) { Game.create }
    let(:frame) { game.frames.create(first_roll: 5) }

    describe "POST /api/v1/games/:game_id/frames/" do

        it "returns status code 201" do
            post "http://localhost:3000/api/v1/games/#{game.id}/frames/"
            expect(response).to have_http_status(:created)
        end

        it "creates a new frame with valida attributes" do
            expect {
                post "http://localhost:3000/api/v1/games/#{game.id}/frames/", params: { first_roll: 5, second_roll: 5 }
            }.to change { game.frames.count }.by(1)
        end

        it "returns status code 422 when invalid" do
            post "http://localhost:3000/api/v1/games/#{game.id}/frames/", params: { first_roll: 11, second_roll: 5 }
            expect(response).to have_http_status(:unprocessable_entity)
        end

        it "returns the created frame" do
            post "http://localhost:3000/api/v1/games/#{game.id}/frames/"
            json = JSON.parse(response.body)
            expect(json["game_id"]).to eq(game.id)
        end
    end

    describe "PATCH /api/v1/games/:game_id/frames/:number" do
        it "returns status code 200" do
            patch "http://localhost:3000/api/v1/games/#{game.id}/frames/#{frame.number}"
            expect(response).to have_http_status(:ok)
        end

        it "updates the frame with valid attributes" do
            patch "http://localhost:3000/api/v1/games/#{game.id}/frames/#{frame.number}", params: { first_roll: 5, second_roll: 5 }
            frame.reload
            expect(frame.first_roll).to eq(5)
            expect(frame.second_roll).to eq(5)
        end

        it "returns 404 when frame not found" do
            patch "http://localhost:3000/api/v1/games/#{game.id}/frames/#{frame.number + 1}", params: { first_roll: 5, second_roll: 5 }
            expect(response).to have_http_status(:not_found)
        end
        
        it "returns 422 when invalid request" do
            patch "http://localhost:3000/api/v1/games/#{game.id}/frames/0", params: { first_roll: 5, second_roll: 5 }
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end
end
