FactoryBot.define do
  factory :vocabulary do
    display { Faker::Games::DnD.monster }
    description { Faker::Lorem.paragraph }
    pronunciation { Faker::Games::DnD.monster }
    translation { Faker::Games::DnD.alignment }
  end
end
