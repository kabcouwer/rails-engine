# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:merchant) }
  end

  describe 'class methods' do
    before :each do
      @merchant1 = create(:merchant)

      @item1 = create(:item, name: 'Titanium Ring', unit_price: 599.99, merchant: @merchant1)
      @item2 = create(:item, description: 'This silver chime will bring you cheer!', unit_price: 799.99, merchant: @merchant1)
      @item3 = create(:item, name: 'Turing', unit_price: 1001.99, merchant: @merchant1)
      @item4 = create(:item, unit_price: 899.99, merchant: @merchant1)
    end

    describe 'class methods' do
      it 'can search by name and description' do
        query = 'ring'
        result = Item.name_search(query)

        expect(result).to eq([@item1, @item2, @item3])
      end

      it 'can search by min price' do
        min = '800'
        max = nil
        result = Item.price_search(min, max)

        expect(result).to eq([@item3, @item4])
      end

      it 'can search by max price' do
        min = nil
        max = '800'
        result = Item.price_search(min, max)

        expect(result).to eq([@item1, @item2])
      end

      it 'can search by min and max price' do
        min = '600'
        max = '900'
        result = Item.price_search(min, max)

        expect(result).to eq([@item2, @item4])
      end
    end
  end
end
