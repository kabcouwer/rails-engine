# frozen_string_literal: true

require 'rails_helper'

describe 'Create and Delete Item API' do
  before :each do
    @merchant1 = create(:merchant)

    @customer1 = create(:customer)

    @item1 = Item.create!(name: 'Titanium Ring',
                          description: 'desc1',
                          unit_price: 599.99,
                          merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'name1',
                          description: 'This silver chime will bring you cheer!',
                          unit_price: 799.99,
                          merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'Turing',
                          description: 'desc2',
                          unit_price: 1001.99,
                          merchant_id: @merchant1.id)
    @item4 = Item.create!(name: 'name2',
                          description: 'desc3',
                          unit_price: 899.99,
                          merchant_id: @merchant1.id)
  end

  describe 'happy paths' do
    it 'can create a new item and then delete it' do
      item_params = {
        name: 'value1',
        description: 'value2',
        unit_price: 100.99,
        merchant_id: @merchant1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      # We include this header to make sure that these params are passed as JSON rather than as plain text
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to have_http_status(201)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      expect { delete "/api/v1/items/#{created_item.id}" }.to change(Item, :count).by(-1)

      expect(response.status).to eq(204)
    end

    it 'deletes invoices if only item on is deleted' do
      invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
      invoice2 = create(:invoice, merchant: @merchant1, customer: @customer1)

      ii1 = create(:invoice_item, invoice: invoice1, item: @item1)
      ii2 = create(:invoice_item, invoice: invoice2, item: @item2)
      ii3 = create(:invoice_item, invoice: invoice2, item: @item3)

      delete "/api/v1/items/#{@item1.id}"

      expect { Invoice.find(invoice1.id) }.to raise_error(ActiveRecord::RecordNotFound)

      delete "/api/v1/items/#{@item2.id}"

      expect { Invoice.find(invoice2.id) }.to_not raise_error
    end
  end

  describe 'edgecases' do
    it 'should ignore any attributes sent by the user which are not allowed and create the item' do
      item_params = {
        name: 'value1',
        description: 'value2',
        unit_price: 100.99,
        merchant_id: @merchant1.id,
        sold_price: 99.99
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to have_http_status(201)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      expect { delete "/api/v1/items/#{created_item.id}" }.to change(Item, :count).by(-1)

      expect(response.status).to eq(204)
    end
  end

  describe 'sad paths' do
    it 'returns an error if merchant_id is missing with new item post' do
      item_params = {
        name: 'value1',
        description: 'value2',
        unit_price: 100.99
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(['Merchant must exist', "Merchant can't be blank", "Merchant can't be blank"])
      expect(response.status).to eq(400)
    end

    it 'returns an error if any attribute is missing with new item post' do
      item_params = {
        name: 'value1',
        description: 'value2',
        merchant_id: @merchant1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to eq(["Unit price can't be blank", 'Unit price is not a number'])
      expect(response.status).to eq(400)
    end

    it 'returns not found error if item to be deleted does not exist' do
      item_id = 1_345_246_257

      delete "/api/v1/items/#{item_id}"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:error]).to eq('Not found')
      expect(response.status).to eq(404)
    end
  end
end
