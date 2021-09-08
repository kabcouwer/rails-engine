# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it 'can search by name' do
      merchant1 = Merchant.create!(name: 'Bob happy Ross')
      merchant2 = Merchant.create!(name: 'Bob Ross')
      merchant3 = Merchant.create!(name: 'bob rossy')
      merchant4 = Merchant.create!(name: 'Art Shop')

      search = 'bOb RoSs'
      result = Merchant.name_search(search)

      expect(result).to eq([merchant2, merchant3])
    end
  end

  describe 'revenue class method' do
    before :each do
      revenue_factories
    end

    it 'can find top merchants by revenue' do
      limit = 4
      result = Merchant.top_merchants_by_revenue(limit)

      expect(result.length).to eq(4)
      expect(result[0].revenue > result[1].revenue).to eq(true)
      expect(result[1].revenue > result[2].revenue).to eq(true)
      expect(result[2].revenue > result[3].revenue).to eq(true)
    end
  end
end
