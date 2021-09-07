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

    @invoice1 = create(:invoice, customer: @customer1, merchant: @merchant1)
    @invoice2 = create(:invoice, customer: @customer1, merchant: @merchant1)


    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item2)
    @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @item3)
  end

  describe 'class methods' do
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

    describe 'instance methods' do
      it 'will delete invoices if only item on invoice is deleted' do
        # happy path
        expect(@item1.invoices.count).to eq(1)

        @item1.destroy_invoices_with_solo_item

        expect(@item1.invoices.count).to eq(0)

        # sad path
        expect(@item2.invoices.count).to eq(1)

        @item2.destroy_invoices_with_solo_item

        expect(@item2.invoices.count).to eq(1)
      end
    end
  end
end
