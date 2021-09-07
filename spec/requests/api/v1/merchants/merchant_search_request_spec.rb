# frozen_string_literal: true

require 'rails_helper'

describe 'Merchant Search API' do
  before :each do
    create_list(:merchant, 5)
  end

  describe 'happy paths' do
    it 'returns first merchant in case-sensitive alphabetical order' do
      merchant1 = Merchant.create!(name: 'Turing')
      merchant2 = Merchant.create!(name: 'Ring World')

      get '/api/v1/merchants/find?name=ring'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchant = body[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq(merchant2.id.to_s)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes].count).to eq(1)
      expect(merchant[:attributes][:name]).to eq(merchant2.name)
    end
  end

  describe 'edgecases' do
    it 'returns no data and ok status if nothing is found' do
      get '/api/v1/merchants/find?name=superduper'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchant = body[:data]

      expect(merchant).to eq({})
    end
  end

  describe 'sad paths' do
    it 'returns error if query does not exist' do
      get '/api/v1/merchants/find'

      expect(response.status).to eq(400)
    end

    it 'returns error if parameter is empty' do
      get '/api/v1/merchants/find?name='

      expect(response.status).to eq(400)
    end
  end
end
