require 'rails_helper'

describe 'Merchant Items API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)
    @item3 = create(:item, merchant: @merchant1)
    @item4 = create(:item, merchant: @merchant1)
    @item5 = create(:item, merchant: @merchant1)
    @item6 = create(:item, merchant: @merchant1)
    @item7 = create(:item, merchant: @merchant1)
  end

  describe 'happy paths' do
    it 'gets all merchants items' do

      get "/api/v1/merchants/#{@merchant1.id}/items"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(7)

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
        expect(item[:attributes][:merchant_id]).to eq(@merchant1.id)
      end
    end
  end

  describe 'sad paths' do
    it 'returns 404 response if merchant not found' do

      get '/api/v1/merchants/983714098375/items'

      expect(response.status).to eq(404)
    end
  end
end
