FactoryBot.define do
  factory :vocabulary do
    display { Faker::Number.hexadecimal(digits: 3)  }
    description { Faker::Lorem.paragraph }
    pronunciation { Faker::Games::DnD.monster }
    translation { Faker::Games::DnD.alignment }
  end
end
