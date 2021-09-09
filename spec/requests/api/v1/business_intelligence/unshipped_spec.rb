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

      expect(merchants.count).to eq(10)
    end
  end
end
