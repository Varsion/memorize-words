FactoryBot.define do
  factory :sentence do
    content { Faker::Lorem.paragraph }
    translation { Faker::Lorem.paragraph }
  end
end
