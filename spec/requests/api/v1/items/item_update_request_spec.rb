# frozen_string_literal: true

require 'rails_helper'

describe 'Update Item API' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
  end

  describe 'happy paths' do
    it 'can update an item' do
      id = @item1.id
      previous_name = @item1.name
      previous_description = @item1.description
      previous_unit_price = @item1.unit_price
      previous_merchant_id = @item1.merchant_id

      item_params = { name: "Charlotte's Web",
                      description: 'book',
                      unit_price: 1099.00,
                      merchant_id: previous_merchant_id }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      # We include this header to make sure that these params are passed as JSON rather than as plain text
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })

      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Charlotte's Web")
      expect(item.description).to_not eq(previous_description)
      expect(item.description).to eq('book')
      expect(item.unit_price).to_not eq(previous_unit_price)
      expect(item.unit_price).to eq(1099.00)
      expect(item.merchant_id).to eq(previous_merchant_id)
    end
  end

  describe 'edgecases' do
    it 'can update an item with 1 attribute adjusted' do
      id = @item1.id
      previous_name = @item1.name
      previous_description = @item1.description
      previous_unit_price = @item1.unit_price
      previous_merchant_id = @item1.merchant_id

      item_params = { name: "Charlotte's Web" }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })

      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Charlotte's Web")
      expect(item.description).to eq(previous_description)
      expect(item.unit_price).to eq(previous_unit_price)
      expect(item.merchant_id).to eq(previous_merchant_id)
    end
  end

  describe 'sad paths' do
    it 'returns not found error if item to be updated does not exist' do
      item_id = 1_345_246_257

      patch "/api/v1/items/#{item_id}"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:error]).to eq('Not found')
      expect(response.status).to eq(404)
    end

    xit 'returns bad request error if item cannot be updated' do
      id = @item1.merchant_id
      item_params = { name: "Charlotte's Web",
                      description: 'book',
                      unit_price: 'word',
                      merchant_id: id }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })

      expect(response.status).to eq(400)
    end
  end
end
