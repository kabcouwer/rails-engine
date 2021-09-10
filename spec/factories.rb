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
  inv17 = create(:invoice, customer: c1, merchant: m1, status: 'packaged')
  inv18 = create(:invoice, customer: c1, merchant: m1, status: 'packaged')
  inv19 = create(:invoice, customer: c1, merchant: m1, status: 'packaged')

  inv4 = create(:invoice, customer: c1, merchant: m2, status: 'shipped')
  inv20 = create(:invoice, customer: c1, merchant: m2, status: 'packaged')

  inv5 = create(:invoice, customer: c1, merchant: m3, status: 'shipped')
  inv6 = create(:invoice, customer: c2, merchant: m3, status: 'shipped')
  inv7 = create(:invoice, customer: c3, merchant: m3, status: 'shipped')
  inv21 = create(:invoice, customer: c1, merchant: m3, status: 'packaged')
  inv22 = create(:invoice, customer: c1, merchant: m3, status: 'packaged')
  inv23 = create(:invoice, customer: c1, merchant: m3, status: 'packaged')


  inv8 = create(:invoice, customer: c1, merchant: m4, status: 'shipped')
  inv9 = create(:invoice, customer: c1, merchant: m4, status: 'shipped')
  inv24 = create(:invoice, customer: c1, merchant: m4, status: 'packaged')
  inv25 = create(:invoice, customer: c1, merchant: m4, status: 'packaged')

  inv10 = create(:invoice, customer: c1, merchant: m5, status: 'shipped')
  inv11 = create(:invoice, customer: c2, merchant: m5, status: 'shipped')
  inv12 = create(:invoice, customer: c3, merchant: m5, status: 'shipped')
  inv13 = create(:invoice, customer: c4, merchant: m5, status: 'shipped')
  inv26 = create(:invoice, customer: c1, merchant: m5, status: 'packaged')
  inv27 = create(:invoice, customer: c1, merchant: m5, status: 'packaged')
  inv28 = create(:invoice, customer: c1, merchant: m5, status: 'packaged')
  inv29 = create(:invoice, customer: c1, merchant: m5, status: 'packaged')

  inv14 = create(:invoice, customer: c1, merchant: m6, status: 'shipped')
  inv15 = create(:invoice, customer: c2, merchant: m6, status: 'shipped')
  inv30 = create(:invoice, customer: c1, merchant: m6, status: 'packaged')
  inv31 = create(:invoice, customer: c1, merchant: m6, status: 'packaged')

  inv16 = create(:invoice, customer: c1, merchant: m7, status: 'shipped')
  inv32 = create(:invoice, customer: c1, merchant: m7, status: 'packaged')

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
  t17 = create(:transaction, invoice: inv17, result: 'success')
  t18 = create(:transaction, invoice: inv18, result: 'success')
  t19 = create(:transaction, invoice: inv19, result: 'success')
  t20 = create(:transaction, invoice: inv20, result: 'success')
  t21 = create(:transaction, invoice: inv21, result: 'success')
  t22 = create(:transaction, invoice: inv22, result: 'success')
  t23 = create(:transaction, invoice: inv23, result: 'success')
  t24 = create(:transaction, invoice: inv24, result: 'success')
  t25 = create(:transaction, invoice: inv25, result: 'success')
  t26 = create(:transaction, invoice: inv26, result: 'success')
  t27 = create(:transaction, invoice: inv27, result: 'success')
  t28 = create(:transaction, invoice: inv28, result: 'success')
  t29 = create(:transaction, invoice: inv29, result: 'success')
  t30 = create(:transaction, invoice: inv30, result: 'success')
  t31 = create(:transaction, invoice: inv31, result: 'success')
  t32 = create(:transaction, invoice: inv32, result: 'success')

  # invoice_items
  ii1 = create(:invoice_item, invoice: inv1, item: i1)
  ii2 = create(:invoice_item, invoice: inv1, item: i2)
  ii3 = create(:invoice_item, invoice: inv2, item: i1)
  ii4 = create(:invoice_item, invoice: inv2, item: i2)
  ii5 = create(:invoice_item, invoice: inv3, item: i1)
  ii6 = create(:invoice_item, invoice: inv3, item: i2)
  ii33 = create(:invoice_item, invoice: inv17, item: i1)
  ii34 = create(:invoice_item, invoice: inv17, item: i2)
  ii35 = create(:invoice_item, invoice: inv18, item: i1)
  ii36 = create(:invoice_item, invoice: inv18, item: i2)
  ii37 = create(:invoice_item, invoice: inv19, item: i1)
  ii38 = create(:invoice_item, invoice: inv19, item: i2)

  ii7 = create(:invoice_item, invoice: inv4, item: i3)
  ii8 = create(:invoice_item, invoice: inv4, item: i4)
  ii39 = create(:invoice_item, invoice: inv20, item: i3)
  ii40 = create(:invoice_item, invoice: inv20, item: i4)

  ii9 = create(:invoice_item, invoice: inv5, item: i5)
  ii10 = create(:invoice_item, invoice: inv5, item: i6)
  ii11 = create(:invoice_item, invoice: inv6, item: i5)
  ii12 = create(:invoice_item, invoice: inv6, item: i6)
  ii13 = create(:invoice_item, invoice: inv7, item: i5)
  ii14 = create(:invoice_item, invoice: inv7, item: i6)
  ii41 = create(:invoice_item, invoice: inv21, item: i5)
  ii42 = create(:invoice_item, invoice: inv21, item: i6)
  ii43 = create(:invoice_item, invoice: inv22, item: i5)
  ii44 = create(:invoice_item, invoice: inv22, item: i6)
  ii45 = create(:invoice_item, invoice: inv23, item: i5)
  ii46 = create(:invoice_item, invoice: inv23, item: i6)

  ii15 = create(:invoice_item, invoice: inv8, item: i7)
  ii16 = create(:invoice_item, invoice: inv8, item: i8)
  ii17 = create(:invoice_item, invoice: inv9, item: i7)
  ii18 = create(:invoice_item, invoice: inv9, item: i8)
  ii47 = create(:invoice_item, invoice: inv24, item: i7)
  ii48 = create(:invoice_item, invoice: inv24, item: i8)
  ii49 = create(:invoice_item, invoice: inv25, item: i7)
  ii50 = create(:invoice_item, invoice: inv25, item: i8)

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
  ii51 = create(:invoice_item, invoice: inv26, item: i9)
  ii52 = create(:invoice_item, invoice: inv26, item: i10)
  ii53 = create(:invoice_item, invoice: inv26, item: i11)
  ii54 = create(:invoice_item, invoice: inv27, item: i9)
  ii55 = create(:invoice_item, invoice: inv27, item: i10)
  ii56 = create(:invoice_item, invoice: inv27, item: i11)
  ii57 = create(:invoice_item, invoice: inv28, item: i9)
  ii58 = create(:invoice_item, invoice: inv28, item: i10)
  ii59 = create(:invoice_item, invoice: inv28, item: i11)
  ii60 = create(:invoice_item, invoice: inv29, item: i9)
  ii61 = create(:invoice_item, invoice: inv29, item: i10)
  ii62 = create(:invoice_item, invoice: inv29, item: i11)

  ii29 = create(:invoice_item, invoice: inv14, item: i12)
  ii30 = create(:invoice_item, invoice: inv15, item: i12)
  ii63 = create(:invoice_item, invoice: inv30, item: i12)
  ii64 = create(:invoice_item, invoice: inv31, item: i12)

  ii31 = create(:invoice_item, invoice: inv16, item: i13)
  ii32 = create(:invoice_item, invoice: inv16, item: i14)
  ii65 = create(:invoice_item, invoice: inv32, item: i13)
  ii66 = create(:invoice_item, invoice: inv32, item: i14)
end
