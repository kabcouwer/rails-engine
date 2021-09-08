# frozen_string_literal: true

class Invoice < ApplicationRecord
  enum status: { shipped: 0, returned: 1, packaged: 2 }

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  validates :customer_id, presence: true
  validates :customer, presence: true
  validates :merchant_id, presence: true
  validates :merchant, presence: true
  validates :status, presence: true
end
