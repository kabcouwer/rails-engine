class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  
  self.per_page = 20
end
