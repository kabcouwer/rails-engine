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
end
