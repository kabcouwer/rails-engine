# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::DcComics.name }
  end

  factory :item do
    name { Faker::Fantasy::Tolkien.character }
    description { Faker::Fantasy::Tolkien.poem }
    unit_price { Faker::Number.binary(digits: 5) }
    merchant
  end

  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  factory :invoice do
    customer
    merchant
    status { %w[shipped returned packaged].sample }
  end

  factory :invoice_item do
    quantity { rand(20) }
    unit_price { rand(10_000) }
    invoice
    item
  end

  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    invoice
    result { %w[failed refunded success].sample }
  end
end
