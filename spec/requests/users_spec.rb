require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "Users" do
    context "register" do
      it "success" do
        post "/users",
             params: {
               name: "Jianhua",
               email: "jianhua@exm.com",
               password: "123456",
               password_confirmation: "123456",
             }.to_json, headers: basic_headers
        expect(response.status).to eq(201)
        expect(response.body).to include_json({
          name: "Jianhua",
          email: "jianhua@exm.com",
        })
        expect(User.count).to eq(1)
      end

      it "failed, password_confirmation wrong" do
        post "/users",
             params: {
               name: "Jianhua",
               email: "jianhua@exm.com",
               password: "123456",
               password_confirmation: "111111",
             }.to_json, headers: basic_headers
        expect(response.status).to eq(422)
        expect(response.body).to include_json({
          fields: ["password_confirmation"],
        })
      end

      it "filed, email is exists" do
      end
    end

    context "get info" do
    end

    context "update info" do
    end

    context "archive account" do
    end
  end
end
