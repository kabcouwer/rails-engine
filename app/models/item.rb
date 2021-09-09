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
    min = 0 if min.nil?
    max = Float::INFINITY if max.nil?

    where('unit_price > ? and unit_price < ?', min.to_f, max.to_f)
  end

  def self.top_items_by_revenue(limit)
    select('items.*',
           'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(invoice_items: [invoice: :transactions])
    .group(:id)
    .order('revenue DESC')
    .limit(limit)
  end

  def destroy_items_invoices
    binding.pry
    invoices.each do |invoice|
      if invoice.items.length == 1
        invoice.destroy
      end
    end
  end
end
