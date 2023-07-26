require "rails_helper"

RSpec.describe "Vocabularies", type: :request do
  before(:each) do
    @user = create(:user)
    @vocs = create_list(:vocabulary, 10)
    @voc = @vocs.sample

    @glossary = @user.glossaries.sample

    @glossary.add_vocabularies(@vocs.pluck(:id))
  end

  context "get /index" do
    # pending
  end

  context "get /show" do
    it "success" do
      get "/glossaries/#{@glossary.id}/vocabularies/#{@voc.id}",
        params: {}, headers: user_headers

      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        id: @voc.id,
      })
    end
  end

  context "get /sample, random vocabulary" do
    it "success, get a random vocabulary" do
      get "/glossaries/#{@glossary.id}/vocabularies/sample",
        params: {}, headers: user_headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(@vocs.pluck(:id).include?(result["id"])).to eq(true)
    end
  end

  context "put /mark, mark a vocabulary" do
    it "success, mark known" do
      put "/glossaries/#{@glossary.id}/vocabularies/#{@voc.id}/mark",
          params: {
            mark: true,
          }.to_json, headers: user_headers
      expect(response.status).to eq(200)
      expect(@voc.user_state(@user)).to eq("known")
      expect(MarkLog.count).to eq(1)
    end
  end
end
