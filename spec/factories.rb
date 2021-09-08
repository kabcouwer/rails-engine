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
    status { [:shipped, :returned, :packaged].sample }
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
    result { [:failed, :refunded, :success].sample }
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
  inv1 = create(:invoice, customer: c1, merchant: m1, status: 'shipped')
  inv2 = create(:invoice, customer: c2, merchant: m1, status: 'shipped')
  inv3 = create(:invoice, customer: c3, merchant: m1, status: 'shipped')

  inv4 = create(:invoice, customer: c1, merchant: m2, status: 'shipped')

  inv5 = create(:invoice, customer: c1, merchant: m3, status: 'shipped')
  inv6 = create(:invoice, customer: c2, merchant: m3, status: 'shipped')
  inv7 = create(:invoice, customer: c3, merchant: m3, status: 'shipped')

  inv8 = create(:invoice, customer: c1, merchant: m4, status: 'shipped')
  inv9 = create(:invoice, customer: c1, merchant: m4, status: 'shipped')

  inv10 = create(:invoice, customer: c1, merchant: m5, status: 'shipped')
  inv11 = create(:invoice, customer: c2, merchant: m5, status: 'shipped')
  inv12 = create(:invoice, customer: c3, merchant: m5, status: 'shipped')
  inv13 = create(:invoice, customer: c4, merchant: m5, status: 'shipped')

  inv14 = create(:invoice, customer: c1, merchant: m6, status: 'shipped')
  inv15 = create(:invoice, customer: c2, merchant: m6, status: 'shipped')

  inv16 = create(:invoice, customer: c1, merchant: m7, status: 'shipped')

  # transaction
  t1 = create(:transaction, invoice: inv1, result: 'success')
  t2 = create(:transaction, invoice: inv2, result: 'success')
  t3 = create(:transaction, invoice: inv3, result: 'success')
  t4 = create(:transaction, invoice: inv4, result: 'success')
  t5 = create(:transaction, invoice: inv5, result: 'success')
  t6 = create(:transaction, invoice: inv6, result: 'success')
  t7 = create(:transaction, invoice: inv7, result: 'success')
  t8 = create(:transaction, invoice: inv8, result: 'success')
  t9 = create(:transaction, invoice: inv9, result: 'success')
  t10 = create(:transaction, invoice: inv10, result: 'success')
  t11 = create(:transaction, invoice: inv11, result: 'success')
  t12 = create(:transaction, invoice: inv12, result: 'success')
  t13 = create(:transaction, invoice: inv13, result: 'success')
  t14 = create(:transaction, invoice: inv14, result: 'success')
  t15 = create(:transaction, invoice: inv15, result: 'success')
  t16 = create(:transaction, invoice: inv16, result: 'success')

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
