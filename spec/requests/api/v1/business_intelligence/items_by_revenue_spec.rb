# frozen_string_literal: true

require 'rails_helper'

describe 'BI - Items by Revenue' do
  before :each do
    revenue_factories
  end

  describe 'happy paths' do
    it 'returns items ranked by revenue' do
      limit = 5

      get "/api/v1/revenue/items?quantity=#{limit}"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(limit)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item[:id].to_i).to be_an(Integer)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item_revenue')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:revenue)
        expect(item[:attributes][:revenue]).to be_a(Float)
      end

    end
  end

  describe 'edge cases' do
    it 'returns 10 items when not given a quantity' do
      get "/api/v1/revenue/items?quantity="

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(10)
    end

    it 'returns 10 when not given quantity param' do
      get "/api/v1/revenue/items"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(10)
    end
    describe 'sad paths' do
      it 'returns error when quantity=0' do
        get "/api/v1/revenue/items?quantity=0"

        expect(response.status).to eq(400)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body[:errors]).to eq(['Quantity needs to be an integer greater than 0'])
      end
    end
  end
end
