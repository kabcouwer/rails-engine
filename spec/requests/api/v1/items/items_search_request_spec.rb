# frozen_string_literal: true

require 'rails_helper'

describe 'Items Search API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, name: 'Titanium Ring', merchant: @merchant1)
    @item2 = create(:item, description: 'This silver chime will bring you cheer!', merchant: @merchant1)
    @item3 = create(:item, name: 'Turing', merchant: @merchant1)
    @item4 = create(:item, merchant: @merchant1)
  end

  describe 'happy paths' do
    it 'gets items that match search by name or description - case insensitive' do
      get '/api/v1/items/find_all?name=ring'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(3)

      expect(items[0]).to have_key(:id)
      expect(items[0][:id]).to eq(@item1.id.to_s)

      expect(items[0]).to have_key(:type)
      expect(items[0][:type]).to eq('item')

      expect(items[0]).to have_key(:attributes)
      expect(items[0][:attributes].count).to eq(4)
      expect(items[0][:attributes][:name]).to eq(@item1.name)
    end
  end

  describe 'edgecases' do
    xit 'returns no data and ok status if nothing is found' do
      get '/api/v1/merchants/find?name=superduper'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchant = body[:data]

      expect(merchant).to eq({})
    end
  end

  describe 'sad paths' do
    xit 'returns error if query does not exist' do
      get '/api/v1/merchants/find'

      expect(response.status).to eq(404)
    end

    xit 'returns error if parameter is empty' do
      get '/api/v1/merchants/find?name='

      expect(response.status).to eq(404)
    end
  end
end
