require 'rails_helper'

RSpec.describe Api::V1::UserPlantsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:plant_1) { FactoryBot.create(:plant, name: 'Snake plant') }
  let!(:plant_2) { FactoryBot.create(:plant, name: 'Aloe Vera') }

  it 'POST' do
    post "/api/v1/users/#{user.id}/plants", params: { plant_id: plant_1.id }
    expect(user.plants.first.name).to eq 'Snake plant'
  end

end