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
    # status { %w[shipped returned packaged].sample }
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
    # result { %w[failed refunded success].sample }
  end
end

def revenue_factories
  # merchants
  m1 = create(:merchant)
  m2 = create(:merchant)
  m3 = create(:merchant)
  m4 = create(:merchant)
  m5 = create(:merchant)
  m6 = create(:merchant)
  m7 = create(:merchant)

  # items
  i1 = create(:item, merchant: m1)
  i2 = create(:item, merchant: m1)
  i3 = create(:item, merchant: m2)
  i4 = create(:item, merchant: m2)
  i5 = create(:item, merchant: m3)
  i6 = create(:item, merchant: m3)
  i7 = create(:item, merchant: m4)
  i8 = create(:item, merchant: m4)
  i9 = create(:item, merchant: m5)
  i10 = create(:item, merchant: m5)
  i11 = create(:item, merchant: m5)
  i12 = create(:item, merchant: m6)
  i13 = create(:item, merchant: m7)
  i14 = create(:item, merchant: m7)

  # customers
  c1 = create(:customer)
  c2 = create(:customer)
  c3 = create(:customer)
  c4 = create(:customer)

  # invoices
  inv1 = create(:invoice, status: :shipped, customer: c1, merchant: m1)
  inv2 = create(:invoice, status: :shipped, customer: c2, merchant: m1)
  inv3 = create(:invoice, status: :shipped, customer: c3, merchant: m1)

  inv4 = create(:invoice, status: :shipped, customer: c1, merchant: m2)

  inv5 = create(:invoice, status: :shipped, customer: c1, merchant: m3)
  inv6 = create(:invoice, status: :shipped, customer: c2, merchant: m3)
  inv7 = create(:invoice, status: :shipped, customer: c3, merchant: m3)

  inv8 = create(:invoice, status: :shipped, customer: c1, merchant: m4)
  inv9 = create(:invoice, status: :shipped, customer: c1, merchant: m4)

  inv10 = create(:invoice, status: :shipped, customer: c1, merchant: m5)
  inv11 = create(:invoice, status: :shipped, customer: c2, merchant: m5)
  inv12 = create(:invoice, status: :shipped, customer: c3, merchant: m5)
  inv13 = create(:invoice, status: :shipped, customer: c4, merchant: m5)

  inv14 = create(:invoice, status: :shipped, customer: c1, merchant: m6)
  inv15 = create(:invoice, status: :shipped, customer: c2, merchant: m6)

  inv16 = create(:invoice, status: :shipped, customer: c1, merchant: m7)

  # transaction
  t1 = create(:transaction, :success, invoice: inv1)
  t2 = create(:transaction, :success, invoice: inv2)
  t3 = create(:transaction, :success, invoice: inv3)
  t4 = create(:transaction, :success, invoice: inv4)
  t5 = create(:transaction, :success, invoice: inv5)
  t6 = create(:transaction, :success, invoice: inv6)
  t7 = create(:transaction, :success, invoice: inv7)
  t8 = create(:transaction, :success, invoice: inv8)
  t9 = create(:transaction, :success, invoice: inv9)
  t10 = create(:transaction, :success, invoice: inv10)
  t11 = create(:transaction, :success, invoice: inv11)
  t12 = create(:transaction, :success, invoice: inv12)
  t13 = create(:transaction, :success, invoice: inv13)
  t14 = create(:transaction, :success, invoice: inv14)
  t15 = create(:transaction, :success, invoice: inv15)
  t16 = create(:transaction, :success, invoice: inv16)

  # invoice_items
  ii1 = create(:invoice_item, invoice: inv1, item: i1)
  ii2 = create(:invoice_item, invoice: inv1, item: i2)
  ii3 = create(:invoice_item, invoice: inv2, item: i1)
  ii4 = create(:invoice_item, invoice: inv2, item: i2)
  ii5 = create(:invoice_item, invoice: inv3, item: i1)
  ii6 = create(:invoice_item, invoice: inv3, item: i2)

  ii7 = create(:invoice_item, invoice: inv4, item: i3)
  ii8 = create(:invoice_item, invoice: inv4, item: i4)

  ii9 = create(:invoice_item, invoice: inv5, item: i5)
  ii10 = create(:invoice_item, invoice: inv5, item: i6)
  ii11 = create(:invoice_item, invoice: inv6, item: i5)
  ii12 = create(:invoice_item, invoice: inv6, item: i6)
  ii13 = create(:invoice_item, invoice: inv7, item: i5)
  ii14 = create(:invoice_item, invoice: inv7, item: i6)

  ii15 = create(:invoice_item, invoice: inv8, item: i7)
  ii16 = create(:invoice_item, invoice: inv8, item: i8)
  ii17 = create(:invoice_item, invoice: inv9, item: i7)
  ii18 = create(:invoice_item, invoice: inv9, item: i8)

  ii19 = create(:invoice_item, invoice: inv10, item: i9)
  ii20 = create(:invoice_item, invoice: inv10, item: i10)
  ii21 = create(:invoice_item, invoice: inv10, item: i11)
  ii22 = create(:invoice_item, invoice: inv11, item: i9)
  ii23 = create(:invoice_item, invoice: inv11, item: i10)
  ii24 = create(:invoice_item, invoice: inv11, item: i11)
  ii25 = create(:invoice_item, invoice: inv12, item: i9)
  ii26 = create(:invoice_item, invoice: inv12, item: i10)
  ii27 = create(:invoice_item, invoice: inv12, item: i11)
  ii28 = create(:invoice_item, invoice: inv13, item: i9)
  ii29 = create(:invoice_item, invoice: inv13, item: i10)
  ii30 = create(:invoice_item, invoice: inv13, item: i11)

  ii29 = create(:invoice_item, invoice: inv14, item: i12)
  ii30 = create(:invoice_item, invoice: inv15, item: i12)

  ii31 = create(:invoice_item, invoice: inv16, item: i13)
  ii32 = create(:invoice_item, invoice: inv16, item: i14)
end
