# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.search(search_params)
    order(:name).where("name ILIKE ?", "%#{search_params}%")
  end
end
