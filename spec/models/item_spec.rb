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

      @item1 = create(:item, name: 'Titanium Ring', merchant: @merchant1)
      @item2 = create(:item, description: 'This silver chime will bring you cheer!', merchant: @merchant1)
      @item3 = create(:item, name: 'Turing', merchant: @merchant1)
      @item4 = create(:item, merchant: @merchant1)
    end

    it 'can search by name and description' do
      query = 'ring'
      result = Item.search(query)

      expect(result).to eq([@item1, @item2, @item3])
    end
  end
end
