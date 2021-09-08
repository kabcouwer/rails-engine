# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.name_search(search_params)
    order(:name).where('name ILIKE ?', "%#{search_params}%")
  end

  def self.top_merchants_by_revenue(limit)
    select("merchants.*",
      "SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .group(:id)
    .order('revenue DESC')
    .limit(limit)
  end

  def revenue
    invoices.joins(:transactions, :invoice_items)
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
