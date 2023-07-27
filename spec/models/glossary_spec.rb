require "rails_helper"

RSpec.describe Glossary, type: :model do
  it "add vocabularies" do
    glossary = create(:glossary)
    vocabulary_1 = create(:vocabulary)
    vocabulary_2 = create(:vocabulary)
    glossary.add_vocabularies([vocabulary_1.id, vocabulary_2.id])
    expect(glossary.vocabularies.count).to eq(2)
  end

  it "vocabularies stats, all known count" do
    user = create(:user)
    glossary = user.glossaries.sample
    voc_unknown = create_list(:vocabulary, 10)
    voc_known = create_list(:vocabulary, 5)
    glossary.add_vocabularies(voc_unknown.pluck(:id))
    glossary.add_vocabularies(voc_known.pluck(:id))

    voc_known.each do |voc|
      create(:mark_log, vocabulary: voc, user: user)
    end

    # now
    # total 15
    # known 5
    # learning 5
    result = glossary.vocabularies_stats(user)

    expect(result).to eq({
      count: 15,
      known_count: 5,
      learning_count: 5,
    })
  end

  it "vocabularies stats, all known count" do
    user = create(:user)
    glossary = user.glossaries.sample
    voc_unknown = create_list(:vocabulary, 10)
    voc_known = create_list(:vocabulary, 5)
    glossary.add_vocabularies(voc_unknown.pluck(:id))
    glossary.add_vocabularies(voc_known.pluck(:id))

    voc_known.each do |voc|
      create(:mark_log, vocabulary: voc, user: user)
    end

    create(:mark_log, vocabulary: voc_unknown.sample, user: user, action: "unknown")

    # now
    # total 15
    # known 5
    # learning 6
    result = glossary.vocabularies_stats(user)

    expect(result).to eq({
      count: 15,
      known_count: 5,
      learning_count: 6,
    })
  end
end
