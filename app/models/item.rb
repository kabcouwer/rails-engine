# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true
  validates :merchant, presence: true

  def self.search(search_params)
    where('name ILIKE ? or description ILIKE ?', "%#{search_params}%", "%#{search_params}%")
  end
end
