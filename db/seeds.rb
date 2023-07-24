# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do |i|
  Vocabulary.create(
    display: Faker::Games::DnD.monster,
    description: Faker::Lorem.paragraph,
    pronunciation: Faker::Games::DnD.monster,
    translation: Faker::Games::DnD.alignment,
  )
end

Vocabulary.all.each do |voc|
  3.times do |i|
    Sentence.create(content: Faker::Lorem.paragraph, translation: Faker::Lorem.paragraph, vocabulary_id: voc.id)
  end
end
