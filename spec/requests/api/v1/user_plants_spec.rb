require 'rails_helper'

RSpec.describe Api::V1::UserPlantsController, type: :request do
  describe '#create' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:plant_1) { FactoryBot.create(:plant, name: 'Snake plant') }
    let!(:plant_2) { FactoryBot.create(:plant, name: 'Aloe Vera') }

    it 'creates a user plant list' do
      post "/api/v1/users/#{user.id}/user_plants", params: { plant_id: plant_1.id }
      expect(response.status).to eq 200
      expect(user.user_plants.first.plant.name).to eq 'Snake plant'
    end

    context 'Validations' do
      it 'has a valid plant id' do
        post "/api/v1/users/#{user.id}/user_plants", params: { plant_id: nil }
        expect(response.status).to eq 400
      end

      it 'has a valid user id' do
        post "/api/v1/users/#{user.id}/user_plants", params: { user_id: nil }
        expect(response.status).to eq 400
      end
    end

    context 'User plant collection' do
      it 'can add many plants in the collection' do
        post "/api/v1/users/#{user.id}/user_plants", params: { plant_id: plant_1.id }
        post "/api/v1/users/#{user.id}/user_plants", params: { plant_id: plant_2.id }
        expect(user.user_plants.count).to eq 2
      end
    end
  end

  describe '#index' do
    describe 'GET /api/v1/users/#{user.id}/user_plants' do
      let!(:user) { FactoryBot.create(:user, id: 1) }
      let!(:plant) { FactoryBot.create(:plant, id: 1) }
      let!(:myplant) { FactoryBot.create(:user_plant, user_id: 1, plant_id: 1) }
      let(:credentials) { user.create_new_auth_token }
      let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

      it 'returns a user collection of plants' do
        get "/api/v1/users/#{user.id}/user_plants", headers: headers
        expect(response.status).to eq 200
        expected_response = eval(file_fixture('user_plants.txt').read)
        expect(response_json).to eq expected_response.as_json
      end
    end
  end
end
