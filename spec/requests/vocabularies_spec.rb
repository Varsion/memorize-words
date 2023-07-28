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
    before(:each) do
      @voc_known = create_list(:vocabulary, 5)
      @glossary.add_vocabularies(@voc_known.pluck(:id))

      @voc_known.each do |voc|
        create(:mark_log, vocabulary: voc, user: @user)
      end

      @voc_unknown = create(:vocabulary)
      @glossary.add_vocabularies([@voc_unknown.id])
      create(:mark_log, vocabulary: @voc_unknown, user: @user, action: "unknown")
    end

    it "success, unknown firstly" do
      get "/glossaries/#{@glossary.id}/vocabularies",
        params: {
          order_firstly: "unknown",
        }, headers: user_headers

      result_ids = JSON.parse(response.body).pluck("id")
      expect(response.status).to eq(200)

      expect(result_ids[0..9]).to match_array(@vocs.pluck(:id))
      expect(result_ids[10]).to eq(@voc_unknown.id)
      expect(result_ids[11..-1]).to eq(@voc_known.pluck(:id))
    end

    it "success, known firstly" do
      get "/glossaries/#{@glossary.id}/vocabularies",
          params: {
            order_firstly: "known",
          }, headers: user_headers

      result_ids = JSON.parse(response.body).pluck("id")
      expect(response.status).to eq(200)

      expect(result_ids[0..4]).to match_array(@voc_known.pluck(:id))
      expect(result_ids[5]).to eq(@voc_unknown.id)
      expect(result_ids[6..-1]).to match_array(@vocs.pluck(:id))
    end

    it "success, with page" do
      get "/glossaries/#{@glossary.id}/vocabularies",
        params: {
          order_firstly: "unknown",
          per_page: 5,
          page: 1,
        }, headers: user_headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.count).to eq(5)
    end
  end

  context "get /show" do
    it "success" do
      get "/glossaries/#{@glossary.id}/vocabularies/#{@voc.id}",
        params: {}, headers: user_headers

      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        id: @voc.id,
        learning_state: "unknown",
      })
    end

    it "success, with known" do
      create(:mark_log, vocabulary: @voc, user: @user)
      get "/glossaries/#{@glossary.id}/vocabularies/#{@voc.id}",
        params: {}, headers: user_headers

      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        id: @voc.id,
        learning_state: "known",
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

  context "get /search" do
    it "success, a key string get many" do
      voc_hello = create(:vocabulary, display: "hello")
      voc_loading = create(:vocabulary, display: "loading")
      key_string = "lo"

      get "/vocabularies/search?search=#{key_string}", headers: user_headers

      result = JSON.parse(response.body)
      expect(result.count).to eq(2)
      expect(result.pluck("display")).to match_array(["hello", "loading"])
    end

    it "success, with display or secondly_display" do
      voc_hello = create(:vocabulary, display: "hello")
      voc_loading = create(:vocabulary, secondly_display: "loading")
      key_string = "lo"

      get "/vocabularies/search?search=#{key_string}", headers: user_headers

      result = JSON.parse(response.body)
      expect(result.count).to eq(2)
      expect(result.pluck("display")).to include("hello")
      expect(result.pluck("secondly_display")).to include("loading")
    end
  end
end
