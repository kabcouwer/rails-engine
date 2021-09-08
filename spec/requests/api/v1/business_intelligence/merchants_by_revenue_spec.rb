# frozen_string_literal: true

require 'rails_helper'

describe 'BI - Merchants by Revenue API' do
  before :each do
    revenue_factories
  end
  describe 'happy paths' do
    it 'gets quantity of merchants by limit query' do
      limit = 5

      get "/api/v1/revenue/merchants?quantity=#{limit}"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchants = body[:data]

      expect(merchants.count).to eq(limit)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)
        expect(merchant[:id].to_i).to be_an(Integer)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant_name_revenue')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes].count).to eq(2)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:revenue)
        expect(merchant[:attributes][:revenue]).to be_a(Float)
      end
    end

    describe 'sad paths' do
      it 'returns error if quantity value is a string' do
        get "/api/v1/revenue/merchants?quantity=ten"

        expect(response.status).to eq(400)
      end

      it 'returns error if quantity value is 0' do
        get "/api/v1/revenue/merchants?quantity=0"

        expect(response.status).to eq(400)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body[:errors]).to eq(['Quantity needs to be an integer greater than 0'])
      end

      it 'returns error if quantity value is blank' do
        get "/api/v1/revenue/merchants?quantity="

        expect(response.status).to eq(400)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body[:errors]).to eq(['Quantity query param must exist'])
      end

      it 'returns error if quantity is blank' do
        get "/api/v1/revenue/merchants?"

        expect(response.status).to eq(400)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body[:errors]).to eq(['Quantity query param must exist'])
      end
    end
  end
end
