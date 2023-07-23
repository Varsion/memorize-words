require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "#create logic" do
    before(:each) do
      @user = create(:user)
    end

    it "success" do
      post "/sessions",
           params: {
             email: @user.email,
             password: "123456",
           }.to_json, headers: basic_headers
      expect(response.status).to eq(201)
      expect(response.body).to include_json({
        user_id: @user.id,
        token: /\w+/,
      })
    end

    it "failed, wrong email" do
      post "/sessions",
           params: {
             email: Faker::Internet.email,
             password: "123456",
           }.to_json, headers: basic_headers
      expect(response.status).to eq(404)
      expect(response.body).to include_json({
        message: "User Not Found",
        fields: [
          "email",
        ],
      })
    end

    it "failed, wrong password" do
      post "/sessions",
           params: {
             email: @user.email,
             password: "111111",
           }.to_json, headers: basic_headers
      expect(response.status).to eq(401)
    end
  end
end
