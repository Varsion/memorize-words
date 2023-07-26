require "rails_helper"

RSpec.describe "Glossaries", type: :request do
  before(:each) do
    @user = create(:user)
  end

  it "user create glossary success" do
    post "/glossaries",
      params: {
        title: "new glossary",
        content: "new glossary content",
      }.to_json, headers: user_headers
    expect(response.status).to eq(201)
    expect(response.body).to include_json({
      title: "new glossary",
      content: "new glossary content",
    })
    expect(@user.glossaries.uniq.count).to eq(2)
  end

  context "index and show" do
    it "get user's glossaries" do
      glossary = create(:glossary)
      @user.glossaries << glossary
      get "/glossaries", headers: user_headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.count).to eq(2)
    end

    it "get glossaries with vocabulary" do
      glossary = @user.glossaries.first
      vocs = create_list(:vocabulary, 5)
      glossary.add_vocabularies(vocs.pluck(:id))
      get "/glossaries/#{glossary.id}", headers: user_headers
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["vocabularies"].count).to eq(5)
    end

    it "get glossaries with vocabulary and sentences" do
      glossary = @user.glossaries.first
      voc = create(:vocabulary)
      sentence = create(:sentence, vocabulary: voc)
      glossary.add_vocabularies([voc.id])
      get "/glossaries/#{glossary.id}", headers: user_headers
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["vocabularies"].count).to eq(1)
      expect(result["vocabularies"][0]["sentences"].count).to eq(1)
    end
  end

  context "update" do
    it "update glossaries info success" do
      glossary = @user.glossaries.first

      put "/glossaries/#{glossary.id}",
        params: {
          title: "New Title",
          content: "New Content",
        }.to_json, headers: user_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        id: glossary.id,
        title: "New Title",
        content: "New Content",
      })
    end

    it "update glossaries info fail, no found or no permission" do
      glossary = create(:glossary)

      put "/glossaries/#{glossary.id}",
        params: {
          title: "New Title",
          content: "New Content",
        }.to_json, headers: user_headers
      expect(response.status).to eq(404)
      expect(response.body).to include_json({
        message: "Glossary Not Found",
      })
    end
  end

  context "add_vocabularies" do
    before(:each) do
      @vocs = create_list(:vocabulary, 5)
    end

    it "success" do
      glossary = @user.glossaries.sample
      put "/glossaries/#{glossary.id}/add_vocabularies",
        params: {
          vocabulary_ids: @vocs.pluck(:id),
        }.to_json, headers: user_headers
      expect(response.status).to eq(200)
      expect(glossary.reload.vocabularies.count).to eq(5)
    end

    it "fail, no your glossary" do
      new_user = create(:user)
      glossary = create(:glossary, owner: new_user)
      put "/glossaries/#{glossary.id}/add_vocabularies",
        params: {
          vocabulary_ids: @vocs.pluck(:id),
        }.to_json, headers: user_headers
      expect(response.status).to eq(401)
    end

    it "fail, can't update system glossary" do
      glossary = create(:glossary, is_system: true)
      put "/glossaries/#{glossary.id}/add_vocabularies",
        params: {
          vocabulary_ids: @vocs.pluck(:id),
        }.to_json, headers: user_headers
      expect(response.status).to eq(401)
    end
  end
end
