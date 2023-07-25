require "rails_helper"

RSpec.describe Glossary, type: :model do
  it "add vocabularies" do
    glossary = create(:glossary)
    vocabulary_1 = create(:vocabulary)
    vocabulary_2 = create(:vocabulary)
    glossary.add_vocabularies([vocabulary_1.id, vocabulary_2.id])
    expect(glossary.vocabularies.count).to eq(2)
  end
end
