# frozen_string_literal: true

require 'rails_helper'

describe 'Merchants API' do
  describe 'happy paths' do
    it 'gets all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchants = body[:data]

      expect(merchants.count).to eq(5)

      merchants.each do |merchant|
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

    it 'returns first 20 merchants and page 1 as default' do
      create_list(:merchant, 25)

      get '/api/v1/merchants'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchants = body[:data]

      expect(merchants.count).to eq(20)
      expect(merchants.first[:attributes][:name]).to eq(Merchant.first.name)
      expect(merchants.last[:attributes][:name]).to eq(Merchant.all[19].name)
    end

    it 'returns correct merchants with per page and page query params' do
      create_list(:merchant, 20)

      get '/api/v1/merchants?per_page=10&page=2'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchants = body[:data]

      expect(merchants.count).to eq(10)
      expect(merchants.first[:attributes][:name]).to eq(Merchant.all[10].name)
      expect(merchants.last[:attributes][:name]).to eq(Merchant.all[19].name)
    end
  end

  describe 'edgecase' do
    it 'gets page 1 and 20 merchants if given zero' do
      create_list(:merchant, 25)

      get '/api/v1/merchants?per_page=0&page=0'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchants = body[:data]

      expect(merchants.count).to eq(20)
      expect(merchants.first[:attributes][:name]).to eq(Merchant.first.name)
      expect(merchants.last[:attributes][:name]).to eq(Merchant.all[19].name)
    end
  end

  describe 'sad paths' do
    it 'returns data as an empty array if query results in no data' do
      create_list(:merchant, 10)

      get '/api/v1/merchants?per_page=10&page=2'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      merchants = body[:data]

      expect(merchants).to eq([])
    end
  end
end
