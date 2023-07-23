require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "Users" do
    context "#create register" do
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
        user = create(:user)
        post "/users",
             params: {
               name: user.name,
               email: user.email,
               password: "123456",
               password_confirmation: "123456",
             }.to_json, headers: basic_headers
        expect(response.status).to eq(422)
        expect(response.body).to include_json({
          fields: [{
            attribute: "email",
          }],
        })
      end
    end

    context "#show get info" do
      before(:each) do
        @user = create(:user)
      end

      it "success" do
        get "/users/#{@user.id}",
          headers: user_headers
        expect(response.status).to eq(200)
        expect(response.body).to include_json({
          name: @user.name,
          email: @user.email,
        })
      end

      it "failed, without token" do
        get "/users/#{@user.id}",
          headers: basic_headers
        expect(response.status).to eq(401)
      end
    end
  end
end
