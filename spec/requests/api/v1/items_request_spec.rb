require 'rails_helper'

describe 'Items API' do
  describe 'happy paths' do
    before :each do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      item3 = create(:item, merchant: merchant1)
      item4 = create(:item, merchant: merchant1)
      item5 = create(:item, merchant: merchant1)
      item6 = create(:item, merchant: merchant2)
      item7 = create(:item, merchant: merchant2)
      item8 = create(:item, merchant: merchant2)
    end

    it 'gets all items' do
      get '/api/v1/items'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      items = body[:data]

      expect(items.count).to eq(5)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item[:id].to_i).to be_an(Integer)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end
  end
end
