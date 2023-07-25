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

  it "get user's glossaries" do
    glossary = create(:glossary)
    @user.glossaries << glossary
    get "/glossaries", headers: user_headers

    result = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(result.count).to eq(2)
  end

  context "update base info" do
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
end
