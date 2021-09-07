# frozen_string_literal: true

class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :customer_id, presence: true
  validates :customer, presence: true
  validates :merchant_id, presence: true
  validates :merchant, presence: true
  validates :status, presence: true
end
