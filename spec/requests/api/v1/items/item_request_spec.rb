require 'rails_helper'

describe 'Item API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
  end

  describe 'happy paths' do
    it 'gets one item' do
      get "/api/v1/items/#{@item1.id}"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      item = body[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:id]).to eq(@item1.id.to_s)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq('item')

      expect(item).to have_key(:attributes)
      expect(item[:attributes].count).to eq(4)

      expect(item[:attributes][:name]).to eq(@item1.name)
      expect(item[:attributes][:description]).to eq(@item1.description)
      expect(item[:attributes][:unit_price]).to eq(@item1.unit_price)
    end
  end

  describe 'sad paths' do
    it 'returns 404 with bad merchant id' do
      get '/api/v1/items/12345'

      expect(response.status).to eq(404)
    end
  end
end
