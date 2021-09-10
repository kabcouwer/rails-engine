require 'rails_helper'

describe 'BI - Unshipped Revenue' do
  before :each do
    revenue_factories
  end

  describe 'happy paths' do
    it 'returns unshipped revenue default 10' do
      get '/api/v1/revenue/unshipped?quantity='

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchants = body[:data]

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)
        expect(merchant[:id].to_i).to be_an(Integer)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('unshipped_order')

        expect(merchant[:attributes]).to have_key(:potential_revenue)
        expect(merchant[:attributes][:potential_revenue]).to be_a(Float)
      end
    end

    describe 'sad paths' do
      it 'returns error if quantity = 0' do
        get '/api/v1/revenue/unshipped?quantity=0'

        expect(response.status).to eq(400)
      end
    end
  end
end
