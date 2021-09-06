require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_numericality_of(:credit_card_number) }
    it { should validate_length_of(:credit_card_number).is_at_least(15).is_at_most(16) }
    it { should validate_presence_of(:result) }
  end
end
