# frozen_string_literal: true

require 'rails_helper'

describe 'Items Search API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = Item.create!(name: 'Titanium Ring',
                          description: 'desc1',
                          unit_price: 599.99,
                          merchant_id: @merchant1.id
                        )
    @item2 = Item.create!(name: 'name1',
                          description: 'This silver chime will bring you cheer!',
                          unit_price: 799.99,
                          merchant_id: @merchant1.id
                        )
    @item3 = Item.create!(name: 'Turing',
                          description: 'desc2',
                          unit_price: 1001.99,
                          merchant_id: @merchant1.id
                        )
    @item4 = Item.create!(name: 'name2',
                          description: 'desc3',
                          unit_price: 899.99,
                          merchant_id: @merchant1.id
                        )
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

      expect(items[1]).to have_key(:id)
      expect(items[1][:id]).to eq(@item2.id.to_s)

      expect(items[1]).to have_key(:type)
      expect(items[1][:type]).to eq('item')

      expect(items[1]).to have_key(:attributes)
      expect(items[1][:attributes].count).to eq(4)
      expect(items[1][:attributes][:name]).to eq(@item2.name)

      expect(items[2]).to have_key(:id)
      expect(items[2][:id]).to eq(@item3.id.to_s)

      expect(items[2]).to have_key(:type)
      expect(items[2][:type]).to eq('item')

      expect(items[2]).to have_key(:attributes)
      expect(items[2][:attributes].count).to eq(4)
      expect(items[2][:attributes][:name]).to eq(@item3.name)
    end

    it 'gets items for min price search' do
      get '/api/v1/items/find_all?min_price=800'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(2)
      expect(items[0][:attributes][:name]).to eq(@item3.name)
      expect(items[1][:attributes][:name]).to eq(@item4.name)
    end

    it 'gets items for max price search' do
      get '/api/v1/items/find_all?max_price=800'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(2)
      expect(items[0][:attributes][:name]).to eq(@item1.name)
      expect(items[1][:attributes][:name]).to eq(@item2.name)
    end

    it 'gets items for min and max price search' do
      get '/api/v1/items/find_all?min_price=600&max_price=900'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      items = body[:data]

      expect(items.count).to eq(2)
      expect(items[0][:attributes][:name]).to eq(@item2.name)
      expect(items[1][:attributes][:name]).to eq(@item4.name)
    end
  end

  describe 'edgecases' do
    it 'returns empty array and ok status if nothing is found' do
      get '/api/v1/items/find_all?name=superduper'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      merchant = body[:data]

      expect(merchant).to eq([])
    end

    it 'returns error if query does not exist' do
      get '/api/v1/items/find_all'

      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Name query or Min/max price query must exist'])
    end

    it 'returns error if parameter is empty' do
      get '/api/v1/items/find_all?name='

      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Name query or Min/max price query must exist'])
    end
  end

  describe 'sad paths' do
    it 'returns error if too many queries exist' do
      get '/api/v1/items/find_all?name=ring&min_price=600'

      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Name OR either/both price parameters may be sent'])
    end

    it 'returns error if too many queries exist' do
      get '/api/v1/items/find_all?name=ring&max_price=600'

      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Name OR either/both price parameters may be sent'])
    end

    it 'returns error if too many queries exist' do
      get '/api/v1/items/find_all?name=ring&min_price=600&max_price=900'

      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Name OR either/both price parameters may be sent'])
    end
  end
end
