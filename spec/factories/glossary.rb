FactoryBot.define do
  factory :glossary do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    is_system { false }
  end
end
