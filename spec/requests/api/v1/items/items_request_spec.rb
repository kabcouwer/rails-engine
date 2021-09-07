# frozen_string_literal: true

require 'rails_helper'

describe 'Items API' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)
    @item3 = create(:item, merchant: @merchant1)
    @item4 = create(:item, merchant: @merchant1)
    @item5 = create(:item, merchant: @merchant1)
    @item6 = create(:item, merchant: @merchant1)
    @item7 = create(:item, merchant: @merchant1)
    @item8 = create(:item, merchant: @merchant2)
    @item9 = create(:item, merchant: @merchant2)
    @item10 = create(:item, merchant: @merchant2)
    @item11 = create(:item, merchant: @merchant2)
    @item12 = create(:item, merchant: @merchant2)
    @item13 = create(:item, merchant: @merchant2)
    @item14 = create(:item, merchant: @merchant2)
    @item15 = create(:item, merchant: @merchant3)
    @item16 = create(:item, merchant: @merchant3)
    @item17 = create(:item, merchant: @merchant3)
    @item18 = create(:item, merchant: @merchant3)
    @item19 = create(:item, merchant: @merchant3)
    @item20 = create(:item, merchant: @merchant3)
    @item21 = create(:item, merchant: @merchant4)
    @item22 = create(:item, merchant: @merchant4)
    @item23 = create(:item, merchant: @merchant4)
    @item24 = create(:item, merchant: @merchant4)
    @item25 = create(:item, merchant: @merchant4)
  end

  describe 'happy paths' do
    it 'gets all items, max of 20 per page' do
      get '/api/v1/items'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(20)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item[:id].to_i).to be_an(Integer)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].count).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'returns first 20 items and page 1 as default' do
      get '/api/v1/items'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(20)
      expect(items.first[:attributes][:name]).to eq(Item.first.name)
      expect(items.last[:attributes][:name]).to eq(Item.all[19].name)
    end

    it 'returns correct items with per page and page query params' do
      get '/api/v1/items?per_page=10&page=2'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(10)
      expect(items.first[:attributes][:name]).to eq(Item.all[10].name)
      expect(items.last[:attributes][:name]).to eq(Item.all[19].name)
    end
  end

  describe 'edgecases' do
    it 'gets page 1 and 20 items if given zero' do
      get '/api/v1/items?per_page=0&page=0'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(20)
      expect(items.first[:attributes][:name]).to eq(Item.first.name)
      expect(items.last[:attributes][:name]).to eq(Item.all[19].name)
    end
  end

  describe 'sad paths' do
    it 'returns data as an empty array if query results in no data' do
      get '/api/v1/items?per_page=25&page=2'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items).to eq([])
    end
  end
end
