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
      result = Merchant.search(search)

      expect(result).to eq([merchant2, merchant3])
    end
  end
end
