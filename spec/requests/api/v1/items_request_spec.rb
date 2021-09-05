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

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
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

    it 'gets one merchant' do
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
      expect(item[:attributes][:name]).to eq(@item1.name)
      expect(item[:attributes][:description]).to eq(@item1.description)
      expect(item[:attributes][:unit_price]).to eq(@item1.unit_price)
    end

    it "can create a new item and then delete it" do
      item_params = ({
        name: "value1",
        description: "value2",
        unit_price: 100.99,
        merchant_id: @merchant1.id
        })

      headers = {'CONTENT_TYPE' => 'application/json'}

      # We include this header to make sure that these params are passed as JSON rather than as plain text
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to have_http_status(201)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      expect{ delete "/api/v1/items/#{created_item.id}" }.to change(Item, :count).by(-1)

      expect{Item.find(created_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(204)
    end

    it 'should ignore any attributes sent by the user which are not allowed and create the item' do
      item_params = ({
        name: "value1",
        description: "value2",
        unit_price: 100.99,
        merchant_id: @merchant1.id,
        sold_price: 99.99
        })

      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to have_http_status(201)
      expect(created_item[:sold_price]).to eq(nil)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      expect{ delete "/api/v1/items/#{created_item.id}" }.to change(Item, :count).by(-1)

      expect{Item.find(created_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(204)
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

    it 'returns 404 with bad merchant id' do
      get '/api/v1/items/12345'

      expect(response.status).to eq(404)
    end

    it 'returns an error if merchant_id is missing with new item post' do
      item_params = ({
        name: "value1",
        description: "value2",
        unit_price: 100.99
        })

      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response.status).to eq(422)
    end

    it 'returns an error if any attribute is missing with new item post' do
      item_params = ({
        name: "value1",
        description: "value2",
        merchant_id: @merchant1.id
        })

      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response.status).to eq(422)
    end

    it 'returns not found error if item to be deleted does not exist' do
      item_id = 1345246257
      delete "/api/v1/items/#{item_id}"

      expect{Item.find(item_id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(404)
    end
  end
end
