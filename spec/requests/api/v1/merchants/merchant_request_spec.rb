# frozen_string_literal: true

require 'rails_helper'

describe 'Merchant API' do
  describe 'happy paths' do
    it 'gets one merchant' do
      merchant1 = create(:merchant)

      get "/api/v1/merchants/#{merchant1.id}"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchant = body[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:id]).to eq(merchant1.id.to_s)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes].count).to eq(1)
      expect(merchant[:attributes][:name]).to eq(merchant1.name)
    end
  end

  describe 'sad paths' do
    it 'returns 404 with bad merchant id' do
      get '/api/v1/merchants/12345'

      expect(response.status).to eq(404)
    end
  end
end
