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

  def self.name_search(name)
    where('name ILIKE ? or description ILIKE ?', "%#{name}%", "%#{name}%")
  end

  def self.price_search(min, max)
    if min.nil?
      min = 0
    end

    if max.nil?
      max = Float::INFINITY
    end

    where('unit_price > ? and unit_price < ?', min.to_f, max.to_f)
  end
end
