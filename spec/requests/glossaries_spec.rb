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
end
