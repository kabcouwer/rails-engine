# frozen_string_literal: true

require 'rails_helper'

describe 'BI - Merchant Revenue' do
  before :each do
    revenue_factories
  end

  describe 'happy paths' do
    it 'gets total revenue for given merchant' do
      merchant = Merchant.first

      get "/api/v1/revenue/merchants/#{merchant.id}"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      result = body[:data]

      expect(result).to have_key(:id)
      expect(result[:id]).to be_a(String)
      expect(result[:id].to_i).to eq(merchant.id)

      expect(result).to have_key(:type)
      expect(result[:type]).to eq('merchant_revenue')

      expect(result).to have_key(:attributes)
      expect(result[:attributes]).to be_a(Hash)
      expect(result[:attributes].count).to eq(1)

      expect(result[:attributes]).to have_key(:revenue)
      expect(result[:attributes][:revenue]).to be_a(Float)
      expect(result[:attributes][:revenue]).to eq(merchant.revenue)
    end
  end

  describe 'sad paths' do
    it 'returns 404 with bad merchant id' do
      id = 12_345

      get "/api/v1/merchants/#{id}"

      expect(response.status).to eq(404)
    end
  end
end
