# frozen_string_literal: true

require 'rails_helper'

describe 'Items Merchant API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)
  end

  describe 'happy paths' do
    it 'gets item merchant info' do
      get "/api/v1/items/#{@item1.id}/merchant"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchant = body[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes].count).to eq(1)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'sad paths' do
    it 'returns 404 response if merchant not found' do
      get '/api/v1/items/983714098375/merchant'

      expect(response.status).to eq(404)
    end
  end
end
