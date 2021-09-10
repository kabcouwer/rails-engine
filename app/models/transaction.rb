# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true
  validates :credit_card_number, numericality: true
  validates :credit_card_number, length: { in: 15..16 }
  validates :result, presence: true
end
