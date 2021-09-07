# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :item_id, presence: true
  validates :item, presence: true
  validates :invoice_id, presence: true
  validates :invoice, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
end
