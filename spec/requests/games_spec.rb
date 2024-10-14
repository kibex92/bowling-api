require 'rails_helper'

RSpec.describe "Games", type: :request do
    let(:game) { Game.create }
    let(:id) { game.id }

    describe "POST /api/v1/games" do
        
        it "returns status code 201" do
            post "http://localhost:3000/api/v1/games"
            expect(response).to have_http_status(:created)
        end
    end

    describe "GET /api/v1/games/:id" do

        it "returns status code 200 when found" do
            get "http://localhost:3000/api/v1/games/#{id}" 
            expect(response).to have_http_status(:ok)
        end

        it "returns status code 404 when not found" do
            get "http://localhost:3000/api/v1/games/0"
            expect(response).to have_http_status(:not_found)
        end

        it "returns game object" do
            get "http://localhost:3000/api/v1/games/#{id}"
            json = JSON.parse(response.body)
            expect(json["game"]["id"]).to eq(id)
        end
    end
end
