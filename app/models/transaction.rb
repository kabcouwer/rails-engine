# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum result: { failed: 0, refunded: 1, success: 2 }

  belongs_to :invoice

  validates :credit_card_number, presence: true
  validates :credit_card_number, numericality: true
  validates :credit_card_number, length: { in: 15..16 }
  validates :result, presence: true
end
